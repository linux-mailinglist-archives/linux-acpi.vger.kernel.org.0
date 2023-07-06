Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF2749A76
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGFLTE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGFLTE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 07:19:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4228173F
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jul 2023 04:18:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262e5e71978so394754a91.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2023 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1688642338; x=1691234338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YRLfqt94qu2i6TB2LNO6a+6VAxI91RFsxf3QPGpfXVo=;
        b=e6/unboA9OBPCeghvSCI8MY5pITOgrUKGaNHtpJk1BaKJ2x48cH7UH6s8JB3Fk040C
         w99FSno6V9Gsq0peEPDVo0Xq+CqAsIBjITFVc4MObDxGlPLyXvCuL5hcHKXSaznOX2d6
         lV8cBmzTZfTvwSbwjnHUGVuWYF0HfaieVApOQDJcMzva/a49076O3ztU6LVMX242xKrG
         LNVfAYTz87NJl+g25px7hEn9DbRVT8kKjJjiSCYVHiEAxfKJbeMk0G6DP1oVGIa7DLv6
         FxIWqF5+EJian8oMPIrmtaSXe987Zkjtj28hQQXviv8bNFKH1HNiRZB61NQtf429LcZZ
         kmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688642338; x=1691234338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRLfqt94qu2i6TB2LNO6a+6VAxI91RFsxf3QPGpfXVo=;
        b=ViZ1LAx9hrDTrfYVMkJnLH0NSkBaNaTt0xZuhGKdaVUH3WUfXDBdKvOuAfgBaawrKQ
         64Y4ptu7bc5EbwIEDam3zm8EFTIbC++WMYVGIrcqjBTXYt11nSkKLmHCU/C7C+Jsf6J+
         SbtsHoFCp4o0vbo0g1956BnG79q1CYrnW4Ua5dxCZKP8UMQ98+UONCo4M5DY2P/aAk7v
         YTIvQik/BsedE8adQq53jMOci1q3d1qoPVZS0+9+Xz9Wl2hLCdw0pYibjkta3NTNNDOg
         8qtSdUdFoIsVZnOtVRkRzSxnqctncKjMnx/S234qVXF6iQQvA6BAnQ8Jkl88P8hOE2ar
         Z87Q==
X-Gm-Message-State: ABy/qLb6FNa/yVtV0aXPyBj4h1zkEQaAXUljpmp8mbPSuL0UOYYzZFDf
        04NWkIPF4+NbANO8OPaa31ddrjjOgn3m5/lnmAwI6g==
X-Google-Smtp-Source: APBJJlGAkLL1XT77vRSufjpcjhFzp6yB0q2vqYN5kWmo92ouvhObbmoZ6n8j4g2YNLPcpp+Vceb+5o6w3jP93XNKji0=
X-Received: by 2002:a17:90b:357:b0:262:ec04:4ff7 with SMTP id
 fh23-20020a17090b035700b00262ec044ff7mr7080980pjb.16.1688642337605; Thu, 06
 Jul 2023 04:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230705213010.390849-1-hdegoede@redhat.com> <20230705213010.390849-15-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-15-hdegoede@redhat.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 6 Jul 2023 12:18:41 +0100
Message-ID: <CAPY8ntBsWqibbnxPszHE74wVo7dtwG2wk-JtR3258WArJ+U8PQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans

On Wed, 5 Jul 2023 at 22:33, Hans de Goede <hdegoede@redhat.com> wrote:
>
> From: Daniel Scally <djrscally@gmail.com>
>
> Add a driver for the DW9719 VCM. The driver creates a v4l2 subdevice
> and registers a control to set the desired focus.
>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3 (Hans de Goede)
> - New patch in v3 of this series based on Dan Scally's initial
>   DW9719 upstream submission:
>   https://lore.kernel.org/all/20211128232115.38833-1-djrscally@gmail.com/
> - Drop hack to enable "vsio" regulator, this is no longer necessary
>   now that there is a device-link making the VCM a runtime-pm consumer
>   of the sensor
> - Add checking of device-properties for sac-mode and vcm-freq,
>   as requested by Sakari, this is done similar to the dw9768:
>   Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
>   Note no devicetree binding doc is added since currently only
>   i2c_device_id enumeration (instantiated by IPU bridge) is
>   supported
> ---
>  MAINTAINERS                |   7 +
>  drivers/media/i2c/Kconfig  |  11 +
>  drivers/media/i2c/Makefile |   1 +
>  drivers/media/i2c/dw9719.c | 427 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 446 insertions(+)
>  create mode 100644 drivers/media/i2c/dw9719.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 494682dd437f..cf8e799f6ea2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6266,6 +6266,13 @@ T:       git git://linuxtv.org/media_tree.git
>  F:     Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml
>  F:     drivers/media/i2c/dw9714.c
>
> +DONGWOON DW9719 LENS VOICE COIL DRIVER
> +M:     Daniel Scally <djrscally@gmail.com>
> +L:     linux-media@vger.kernel.org
> +S:     Maintained
> +T:     git git://linuxtv.org/media_tree.git
> +F:     drivers/media/i2c/dw9719.c
> +
>  DONGWOON DW9768 LENS VOICE COIL DRIVER
>  L:     linux-media@vger.kernel.org
>  S:     Orphan
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 26dc365365d8..4864f1df3c7a 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -875,6 +875,17 @@ config VIDEO_DW9714
>           capability. This is designed for linear control of
>           voice coil motors, controlled via I2C serial interface.
>
> +config VIDEO_DW9719
> +       tristate "DW9719 lens voice coil support"
> +       depends on I2C && VIDEO_DEV
> +       select MEDIA_CONTROLLER
> +       select VIDEO_V4L2_SUBDEV_API
> +       select V4L2_ASYNC
> +       help
> +         This is a driver for the DW9719 camera lens voice coil.
> +         This is designed for linear control of voice coil motors,
> +         controlled via I2C serial interface.
> +
>  config VIDEO_DW9768
>         tristate "DW9768 lens voice coil support"
>         depends on I2C && VIDEO_DEV
> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> index d175a2e2fb19..745f8d07e649 100644
> --- a/drivers/media/i2c/Makefile
> +++ b/drivers/media/i2c/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_VIDEO_DS90UB913) += ds90ub913.o
>  obj-$(CONFIG_VIDEO_DS90UB953) += ds90ub953.o
>  obj-$(CONFIG_VIDEO_DS90UB960) += ds90ub960.o
>  obj-$(CONFIG_VIDEO_DW9714) += dw9714.o
> +obj-$(CONFIG_VIDEO_DW9719) += dw9719.o
>  obj-$(CONFIG_VIDEO_DW9768) += dw9768.o
>  obj-$(CONFIG_VIDEO_DW9807_VCM) += dw9807-vcm.o
>  obj-$(CONFIG_VIDEO_ET8EK8) += et8ek8/
> diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
> new file mode 100644
> index 000000000000..7b83ae102131
> --- /dev/null
> +++ b/drivers/media/i2c/dw9719.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2012 Intel Corporation
> +
> +/*
> + * Based on linux/modules/camera/drivers/media/i2c/imx/dw9719.c in this repo:
> + * https://github.com/ZenfoneArea/android_kernel_asus_zenfone5
> + */
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-subdev.h>
> +
> +#define DW9719_MAX_FOCUS_POS   1023
> +#define DW9719_CTRL_STEPS      16
> +#define DW9719_CTRL_DELAY_US   1000
> +#define DELAY_MAX_PER_STEP_NS  (1000000 * 1023)
> +
> +#define DW9719_INFO                    0
> +#define DW9719_ID                      0xF1
> +#define DW9719_CONTROL                 2
> +#define DW9719_VCM_CURRENT             3
> +
> +#define DW9719_MODE                    6
> +#define DW9719_VCM_FREQ                        7
> +
> +#define DW9719_MODE_SAC_SHIFT          4
> +#define DW9719_MODE_SAC3               4
> +
> +#define DW9719_DEFAULT_VCM_FREQ                0x60
> +
> +#define DW9719_ENABLE_RINGING          0x02

This register setup and the ramping up/down code is nearly identical
to the existing dw9807-vcm driver[1]. Admittedly that doesn't expose
SAC (Smart Actuator Control) for damping the movement, but dw9807 does
support it.

The only really quirky bit here is the "Jiggle SCL pin to wake up
device", but I can't find a datasheet to know anything more about
that. The other apparent distinction would be whether DW9719 has the
VBUSY bit in the status register that dw9807 is abiding by, whilst
this driver doesn't.

Should this be a new driver, or a variant of dw9807-vcm?

Cheers
  Dave

[1] https://github.com/torvalds/linux/blob/master/drivers/media/i2c/dw9807-vcm.c

> +
> +#define to_dw9719_device(x) container_of(x, struct dw9719_device, sd)
> +
> +struct dw9719_device {
> +       struct device *dev;
> +       struct i2c_client *client;
> +       struct regulator *regulator;
> +       struct v4l2_subdev sd;
> +       u32 sac_mode;
> +       u32 vcm_freq;
> +
> +       struct dw9719_v4l2_ctrls {
> +               struct v4l2_ctrl_handler handler;
> +               struct v4l2_ctrl *focus;
> +       } ctrls;
> +};
> +
> +static int dw9719_i2c_rd8(struct i2c_client *client, u8 reg, u8 *val)
> +{
> +       struct i2c_msg msg[2];
> +       u8 buf[2] = { reg };
> +       int ret;
> +
> +       msg[0].addr = client->addr;
> +       msg[0].flags = 0;
> +       msg[0].len = 1;
> +       msg[0].buf = buf;
> +
> +       msg[1].addr = client->addr;
> +       msg[1].flags = I2C_M_RD;
> +       msg[1].len = 1;
> +       msg[1].buf = &buf[1];
> +       *val = 0;
> +
> +       ret = i2c_transfer(client->adapter, msg, 2);
> +       if (ret < 0)
> +               return ret;
> +
> +       *val = buf[1];
> +
> +       return 0;
> +}
> +
> +static int dw9719_i2c_wr8(struct i2c_client *client, u8 reg, u8 val)
> +{
> +       struct i2c_msg msg;
> +       int ret;
> +
> +       u8 buf[2] = { reg, val };
> +
> +       msg.addr = client->addr;
> +       msg.flags = 0;
> +       msg.len = sizeof(buf);
> +       msg.buf = buf;
> +
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +
> +       return ret < 0 ? ret : 0;
> +}
> +
> +static int dw9719_i2c_wr16(struct i2c_client *client, u8 reg, u16 val)
> +{
> +       struct i2c_msg msg;
> +       u8 buf[3] = { reg };
> +       int ret;
> +
> +       put_unaligned_be16(val, buf + 1);
> +
> +       msg.addr = client->addr;
> +       msg.flags = 0;
> +       msg.len = sizeof(buf);
> +       msg.buf = buf;
> +
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +
> +       return ret < 0 ? ret : 0;
> +}
> +
> +static int dw9719_detect(struct dw9719_device *dw9719)
> +{
> +       int ret;
> +       u8 val;
> +
> +       ret = dw9719_i2c_rd8(dw9719->client, DW9719_INFO, &val);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (val != DW9719_ID) {
> +               dev_err(dw9719->dev, "Failed to detect correct id\n");
> +               ret = -ENXIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dw9719_power_down(struct dw9719_device *dw9719)
> +{
> +       return regulator_disable(dw9719->regulator);
> +}
> +
> +static int dw9719_power_up(struct dw9719_device *dw9719)
> +{
> +       int ret;
> +
> +       ret = regulator_enable(dw9719->regulator);
> +       if (ret)
> +               return ret;
> +
> +       /* Jiggle SCL pin to wake up device */
> +       ret = dw9719_i2c_wr8(dw9719->client, DW9719_CONTROL, 1);
> +
> +       /* Need 100us to transit from SHUTDOWN to STANDBY*/
> +       usleep_range(100, 1000);
> +
> +       ret = dw9719_i2c_wr8(dw9719->client, DW9719_CONTROL,
> +                            DW9719_ENABLE_RINGING);
> +       if (ret < 0)
> +               goto fail_powerdown;
> +
> +       ret = dw9719_i2c_wr8(dw9719->client, DW9719_MODE,
> +                            dw9719->sac_mode << DW9719_MODE_SAC_SHIFT);
> +       if (ret < 0)
> +               goto fail_powerdown;
> +
> +       ret = dw9719_i2c_wr8(dw9719->client, DW9719_VCM_FREQ, dw9719->vcm_freq);
> +       if (ret < 0)
> +               goto fail_powerdown;
> +
> +       return 0;
> +
> +fail_powerdown:
> +       dw9719_power_down(dw9719);
> +       return ret;
> +}
> +
> +static int dw9719_t_focus_abs(struct dw9719_device *dw9719, s32 value)
> +{
> +       int ret;
> +
> +       value = clamp(value, 0, DW9719_MAX_FOCUS_POS);
> +       ret = dw9719_i2c_wr16(dw9719->client, DW9719_VCM_CURRENT, value);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int dw9719_set_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +       struct dw9719_device *dw9719 = container_of(ctrl->handler,
> +                                                   struct dw9719_device,
> +                                                   ctrls.handler);
> +       int ret;
> +
> +       /* Only apply changes to the controls if the device is powered up */
> +       if (!pm_runtime_get_if_in_use(dw9719->dev))
> +               return 0;
> +
> +       switch (ctrl->id) {
> +       case V4L2_CID_FOCUS_ABSOLUTE:
> +               ret = dw9719_t_focus_abs(dw9719, ctrl->val);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       pm_runtime_put(dw9719->dev);
> +
> +       return ret;
> +}
> +
> +static const struct v4l2_ctrl_ops dw9719_ctrl_ops = {
> +       .s_ctrl = dw9719_set_ctrl,
> +};
> +
> +static int __maybe_unused dw9719_suspend(struct device *dev)
> +{
> +       struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +       struct dw9719_device *dw9719 = to_dw9719_device(sd);
> +       int ret;
> +       int val;
> +
> +       for (val = dw9719->ctrls.focus->val; val >= 0;
> +            val -= DW9719_CTRL_STEPS) {
> +               ret = dw9719_t_focus_abs(dw9719, val);
> +               if (ret)
> +                       return ret;
> +
> +               usleep_range(DW9719_CTRL_DELAY_US, DW9719_CTRL_DELAY_US + 10);
> +       }
> +
> +       return dw9719_power_down(dw9719);
> +}
> +
> +static int __maybe_unused dw9719_resume(struct device *dev)
> +{
> +       struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +       struct dw9719_device *dw9719 = to_dw9719_device(sd);
> +       int current_focus = dw9719->ctrls.focus->val;
> +       int ret;
> +       int val;
> +
> +       ret = dw9719_power_up(dw9719);
> +       if (ret)
> +               return ret;
> +
> +       for (val = current_focus % DW9719_CTRL_STEPS; val < current_focus;
> +            val += DW9719_CTRL_STEPS) {
> +               ret = dw9719_t_focus_abs(dw9719, val);
> +               if (ret)
> +                       goto err_power_down;
> +
> +               usleep_range(DW9719_CTRL_DELAY_US, DW9719_CTRL_DELAY_US + 10);
> +       }
> +
> +       return 0;
> +
> +err_power_down:
> +       dw9719_power_down(dw9719);
> +       return ret;
> +}
> +
> +static int dw9719_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> +{
> +       return pm_runtime_resume_and_get(sd->dev);
> +}
> +
> +static int dw9719_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> +{
> +       pm_runtime_put(sd->dev);
> +
> +       return 0;
> +}
> +
> +static const struct v4l2_subdev_internal_ops dw9719_internal_ops = {
> +       .open = dw9719_open,
> +       .close = dw9719_close,
> +};
> +
> +static int dw9719_init_controls(struct dw9719_device *dw9719)
> +{
> +       const struct v4l2_ctrl_ops *ops = &dw9719_ctrl_ops;
> +       int ret;
> +
> +       ret = v4l2_ctrl_handler_init(&dw9719->ctrls.handler, 1);
> +       if (ret)
> +               return ret;
> +
> +       dw9719->ctrls.focus = v4l2_ctrl_new_std(&dw9719->ctrls.handler, ops,
> +                                               V4L2_CID_FOCUS_ABSOLUTE, 0,
> +                                               DW9719_MAX_FOCUS_POS, 1, 0);
> +
> +       if (dw9719->ctrls.handler.error) {
> +               dev_err(dw9719->dev, "Error initialising v4l2 ctrls\n");
> +               ret = dw9719->ctrls.handler.error;
> +               goto err_free_handler;
> +       }
> +
> +       dw9719->sd.ctrl_handler = &dw9719->ctrls.handler;
> +
> +       return ret;
> +
> +err_free_handler:
> +       v4l2_ctrl_handler_free(&dw9719->ctrls.handler);
> +       return ret;
> +}
> +
> +static const struct v4l2_subdev_ops dw9719_ops = { };
> +
> +static int dw9719_probe(struct i2c_client *client)
> +{
> +       struct dw9719_device *dw9719;
> +       int ret;
> +
> +       dw9719 = devm_kzalloc(&client->dev, sizeof(*dw9719), GFP_KERNEL);
> +       if (!dw9719)
> +               return -ENOMEM;
> +
> +       dw9719->client = client;
> +       dw9719->dev = &client->dev;
> +
> +       dw9719->sac_mode = DW9719_MODE_SAC3;
> +       dw9719->vcm_freq = DW9719_DEFAULT_VCM_FREQ;
> +
> +       /* Optional indication of SAC mode select */
> +       device_property_read_u32(&client->dev, "dongwoon,sac-mode",
> +                                &dw9719->sac_mode);
> +
> +       /* Optional indication of VCM frequency */
> +       device_property_read_u32(&client->dev, "dongwoon,vcm-freq",
> +                                &dw9719->vcm_freq);
> +
> +       dw9719->regulator = devm_regulator_get(&client->dev, "vdd");
> +       if (IS_ERR(dw9719->regulator))
> +               return dev_err_probe(&client->dev, PTR_ERR(dw9719->regulator),
> +                                    "getting regulator\n");
> +
> +       v4l2_i2c_subdev_init(&dw9719->sd, client, &dw9719_ops);
> +       dw9719->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +       dw9719->sd.internal_ops = &dw9719_internal_ops;
> +
> +       ret = dw9719_init_controls(dw9719);
> +       if (ret)
> +               return ret;
> +
> +       ret = media_entity_pads_init(&dw9719->sd.entity, 0, NULL);
> +       if (ret < 0)
> +               goto err_free_ctrl_handler;
> +
> +       dw9719->sd.entity.function = MEDIA_ENT_F_LENS;
> +
> +       /*
> +        * We need the driver to work in the event that pm runtime is disable in
> +        * the kernel, so power up and verify the chip now. In the event that
> +        * runtime pm is disabled this will leave the chip on, so that the lens
> +        * will work.
> +        */
> +
> +       ret = dw9719_power_up(dw9719);
> +       if (ret)
> +               goto err_cleanup_media;
> +
> +       ret = dw9719_detect(dw9719);
> +       if (ret)
> +               goto err_powerdown;
> +
> +       pm_runtime_set_active(&client->dev);
> +       pm_runtime_get_noresume(&client->dev);
> +       pm_runtime_enable(&client->dev);
> +
> +       ret = v4l2_async_register_subdev(&dw9719->sd);
> +       if (ret < 0)
> +               goto err_pm_runtime;
> +
> +       pm_runtime_set_autosuspend_delay(&client->dev, 1000);
> +       pm_runtime_use_autosuspend(&client->dev);
> +       pm_runtime_put_autosuspend(&client->dev);
> +
> +       return ret;
> +
> +err_pm_runtime:
> +       pm_runtime_disable(&client->dev);
> +       pm_runtime_put_noidle(&client->dev);
> +err_powerdown:
> +       dw9719_power_down(dw9719);
> +err_cleanup_media:
> +       media_entity_cleanup(&dw9719->sd.entity);
> +err_free_ctrl_handler:
> +       v4l2_ctrl_handler_free(&dw9719->ctrls.handler);
> +
> +       return ret;
> +}
> +
> +static void dw9719_remove(struct i2c_client *client)
> +{
> +       struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +       struct dw9719_device *dw9719 = container_of(sd, struct dw9719_device, sd);
> +
> +       pm_runtime_disable(&client->dev);
> +       v4l2_async_unregister_subdev(sd);
> +       v4l2_ctrl_handler_free(&dw9719->ctrls.handler);
> +       media_entity_cleanup(&dw9719->sd.entity);
> +}
> +
> +static const struct i2c_device_id dw9719_id_table[] = {
> +       { "dw9719" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, dw9719_id_table);
> +
> +static const struct dev_pm_ops dw9719_pm_ops = {
> +       SET_RUNTIME_PM_OPS(dw9719_suspend, dw9719_resume, NULL)
> +};
> +
> +static struct i2c_driver dw9719_i2c_driver = {
> +       .driver = {
> +               .name = "dw9719",
> +               .pm = &dw9719_pm_ops,
> +       },
> +       .probe_new = dw9719_probe,
> +       .remove = dw9719_remove,
> +       .id_table = dw9719_id_table,
> +};
> +module_i2c_driver(dw9719_i2c_driver);
> +
> +MODULE_AUTHOR("Daniel Scally <djrscally@gmail.com>");
> +MODULE_DESCRIPTION("DW9719 VCM Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.41.0
>
