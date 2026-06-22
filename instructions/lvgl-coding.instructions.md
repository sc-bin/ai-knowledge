---
description: "Use when: 处理 LVGL（LittlevGL）图形库相关的 C/C++ 代码。要求组件按文件/文件夹拆分、文件间解耦、定时器回调安全操作。"
applyTo: ["**/*.c", "**/*.h", "**/*.cpp", "**/*.hpp"]
---
# LVGL 编码规范

## 1. 组件化文件组织（类前端风格）
- 每个 LVGL 组件（如页面、面板、弹窗、键盘等）**独立为一个文件夹**，内含同名 `.c` / `.h` 文件。
- 文件夹命名示例：
  ```
  ui/
  ├── main_screen/
  │   ├── main_screen.c
  │   └── main_screen.h
  ├── keyboard/
  │   ├── keyboard.c
  │   └── keyboard.h
  └── status_bar/
      ├── status_bar.c
      └── status_bar.h
  ```
- 组件文件夹内可包含该组件专属的资源、子组件或样式文件。

## 2. 文件间解耦
- **每个组件的 `.c` 文件内的函数，尽量只操作本文件内创建的 LVGL 对象（`lv_obj_t *`）**。
- 如需跨组件通信，优先使用 **LVGL 消息机制（`lv_msg`）** 或自定义回调函数，避免直接访问其他组件的内部对象。
- 各组件对外暴露的接口尽量精简，只提供必要的创建、更新、销毁函数。

## 3. 定时器回调中安全操作组件
- 在 `lv_timer_cb`（定时器回调）函数内，**访问任何 `lv_obj_t *` 之前必须先判断该对象是否仍然存在**。
- 推荐的做法：将组件指针注册到 `lv_event` 或 `lv_timer` 的 user_data 中，回调内通过 `lv_obj_is_valid()` 检查后再操作。
- 示例：

```c
static void my_timer_cb(lv_timer_t *timer)
{
    lv_obj_t *obj = (lv_obj_t *)lv_timer_get_user_data(timer);

    // 先判断对象是否还存在
    if (!lv_obj_is_valid(obj)) {
        lv_timer_del(timer);  // 对象已销毁，删除定时器
        return;
    }

    // 安全操作对象
    lv_obj_set_x(obj, lv_obj_get_x(obj) + 1);
}
```

- 同理，在 `lv_anim_cb`（动画回调）中操作组件对象前，也要先检查 `lv_obj_is_valid()`。
