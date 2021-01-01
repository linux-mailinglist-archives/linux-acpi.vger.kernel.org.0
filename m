Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D572E83C7
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Jan 2021 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbhAAM6K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Jan 2021 07:58:10 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52555 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbhAAM6J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jan 2021 07:58:09 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id B7B0E58041D;
        Fri,  1 Jan 2021 07:57:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 01 Jan 2021 07:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jTN6s9l//+MKe
        FOJzgjmYtJ1NIMBjH6i+mDCTXmMYwU=; b=Rf8Iv1pu3XUAmjBViGjfpqcPpNCdz
        RPPTJU9SuXqTg8h/p2erZXIktljC/md3hqFgFnHoIKUQUm/jIbi/8d8d7HVZRnJA
        lqHr8jcUlBtfUWyft8oEhWYSWoJeQ/FAfpSn/aYH4fPaF67eqRyV8bXn31Uf7FR/
        wobGKiYoifAfE9QeF4nUWNl0S97+g+wGfchDLfPKMnP1pDwqHqirwj+Hv8L8kUSJ
        QRi78pIq9IWwmv2BDUh7vxXGwLObvp+Fjt4f4RXjR6tUWset7toCkkqFD8XCFdxr
        4WC4BfZaZkOjsEQfu+4HuYfSmmkGZuTsWjSrN2xNoH0JAUQEDLJYFgZkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jTN6s9l//+MKeFOJzgjmYtJ1NIMBjH6i+mDCTXmMYwU=; b=pEnHacWT
        rf8bqROK4E1DmeMZWQGZtNNKVXQaepaDi4V7rJQv4HWcUVLH8UoViCo1JJZYNAVS
        LwGl2o0GN3wcCcY5sd+eWR+nWUbDnVtHvbwNojGzQ+fnz57TH6W+rQAQmTv9Qbwx
        iOQaHPHIDihAmq+zfATXntinm4t/pXj4TWLSRJBKckeN2mhuXBF1PfD812327Kpf
        ymEjo5GwCVnzLEekBvE3HrQbBoc5+NtrF9bxYd/5g0DCJYjZI9cRYLWnFHbGGevC
        6v/q0RRnDfXBvQYfE1i0I2cxIf70Y+p2Xuhg2WAjqhR9QwoghBL3LibjZBPLnVkk
        5H7h+HxRUXeUGQ==
X-ME-Sender: <xms:HRzvX5nt5ZlyWiVzjPCsN3R9H_ekl7l3_k_n5nES061E9SOCkk0aRQ>
    <xme:HRzvX028XxmYWM5-tK4iBzecQRdQNGBuJkBU4s_gSslde29yQ8_piI_wAVgQCupZB
    2FVBcgD15bRJH48Cy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvjedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepjeeihffgteelkeelffdukedtheevudejvdegkeekjeefhffhhfet
    udetgfdtffeunecukfhppeeitddrudejjedrudekledrudejudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:HRzvX_qyTCWO1CSOb9qOlNgMYHj2t6iRS84HEn5PX4M2pW35tiX37w>
    <xmx:HRzvX5k80Nkl6OMJj11iSzGDaHrlD-2F2DZVE72V-ME8AcEvBZzeuA>
    <xmx:HRzvX30Ha5vrnmXLWSzY3xGW0DT5q0QVljgvpy9mFeGEiS7BXX9xQw>
    <xmx:HRzvXxrr_ZOei-3ceLjfDXV_piru1mQnqWglfgMRHpboKR7t1gkaFg>
Received: from strike.202.net.flygoat.com (unknown [60.177.189.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1622724005A;
        Fri,  1 Jan 2021 07:56:55 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: ideapad-laptop: DYTC Platform profile support
Date:   Fri,  1 Jan 2021 20:56:26 +0800
Message-Id: <20210101125629.20974-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support to ideapad-laptop for Lenovo platforms that have DYTC
version 5 support or newer to use the platform profile feature.

Mostly based on Mark Pearson <markpearson@lenovo.com>'s thinkpad-acpi
work but massaged to fit ideapad driver.

Note that different from ThinkPads, IdeaPads's Thermal Hotkey won't
trigger profile wwitch itself, we'll leave it for userspace programs.

Tested on Lenovo Yoga-14SARE Chinese Edition.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/platform/x86/Kconfig          |   1 +
 drivers/platform/x86/ideapad-laptop.c | 281 ++++++++++++++++++++++++++
 2 files changed, 282 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 91e6176cdfbd..8059143c21bb 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -624,6 +624,7 @@ config IDEAPAD_LAPTOP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on ACPI_WMI || ACPI_WMI = n
+	depends on ACPI_PLATFORM_PROFILE
 	select INPUT_SPARSEKMAP
 	help
 	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 7598cd46cf60..8e91b813e623 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -15,6 +15,7 @@
 #include <linux/acpi.h>
 #include <linux/rfkill.h>
 #include <linux/platform_device.h>
+#include <linux/platform_profile.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/backlight.h>
@@ -77,6 +78,12 @@ enum {
 	VPCCMD_W_BL_POWER = 0x33,
 };
 
+struct ideapad_dytc_priv {
+	enum platform_profile_option current_profile;
+	struct platform_profile_handler handler;
+	struct mutex mutex;
+};
+
 struct ideapad_rfk_priv {
 	int dev;
 	struct ideapad_private *priv;
@@ -89,6 +96,7 @@ struct ideapad_private {
 	struct platform_device *platform_device;
 	struct input_dev *inputdev;
 	struct backlight_device *blightdev;
+	struct ideapad_dytc_priv *dytc;
 	struct dentry *debug;
 	unsigned long cfg;
 	bool has_hw_rfkill_switch;
@@ -136,6 +144,28 @@ static int method_int1(acpi_handle handle, char *method, int cmd)
 	return ACPI_FAILURE(status) ? -1 : 0;
 }
 
+static int method_dytc(acpi_handle handle, int cmd, int *ret)
+{
+	acpi_status status;
+	unsigned long long result;
+	struct acpi_object_list params;
+	union acpi_object in_obj;
+
+	params.count = 1;
+	params.pointer = &in_obj;
+	in_obj.type = ACPI_TYPE_INTEGER;
+	in_obj.integer.value = cmd;
+
+	status = acpi_evaluate_integer(handle, "DYTC", &params, &result);
+
+	if (ACPI_FAILURE(status)) {
+		*ret = -1;
+		return -1;
+	}
+	*ret = result;
+	return 0;
+}
+
 static int method_vpcr(acpi_handle handle, int cmd, int *ret)
 {
 	acpi_status status;
@@ -546,6 +576,250 @@ static const struct attribute_group ideapad_attribute_group = {
 	.attrs = ideapad_attributes
 };
 
+/*
+ * DYTC Platform profile
+ */
+#define DYTC_CMD_QUERY        0 /* To get DYTC status - enable/revision */
+#define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
+#define DYTC_CMD_GET          2 /* To get current IC function and mode */
+#define DYTC_CMD_RESET    0x1ff /* To reset back to default */
+
+#define DYTC_QUERY_ENABLE_BIT 8  /* Bit        8 - 0 = disabled, 1 = enabled */
+#define DYTC_QUERY_SUBREV_BIT 16 /* Bits 16 - 27 - sub revision */
+#define DYTC_QUERY_REV_BIT    28 /* Bits 28 - 31 - revision */
+
+#define DYTC_GET_FUNCTION_BIT 8  /* Bits  8-11 - function setting */
+#define DYTC_GET_MODE_BIT     12 /* Bits 12-15 - mode setting */
+
+#define DYTC_SET_FUNCTION_BIT 12 /* Bits 12-15 - function setting */
+#define DYTC_SET_MODE_BIT     16 /* Bits 16-19 - mode setting */
+#define DYTC_SET_VALID_BIT    20 /* Bit     20 - 1 = on, 0 = off */
+
+#define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
+#define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
+#define DYTC_FUNCTION_MMC     11 /* Function = 11, desk mode */
+
+#define DYTC_MODE_PERFORM     2  /* High power mode aka performance */
+#define DYTC_MODE_QUIET       3  /* Low power mode aka quiet */
+#define DYTC_MODE_BALANCE   0xF  /* Default mode aka balanced */
+
+#define DYTC_SET_COMMAND(function, mode, on) \
+	(DYTC_CMD_SET | (function) << DYTC_SET_FUNCTION_BIT | \
+	 (mode) << DYTC_SET_MODE_BIT | \
+	 (on) << DYTC_SET_VALID_BIT)
+
+#define DYTC_DISABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 0)
+
+#define DYTC_ENABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 1)
+
+static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
+{
+	switch (dytcmode) {
+	case DYTC_MODE_QUIET:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	case DYTC_MODE_BALANCE:
+		*profile =  PLATFORM_PROFILE_BALANCED;
+		break;
+	case DYTC_MODE_PERFORM:
+		*profile =  PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	default: /* Unknown mode */
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int convert_profile_to_dytc(enum platform_profile_option profile, int *perfmode)
+{
+	switch (profile) {
+	case PLATFORM_PROFILE_QUIET:
+		*perfmode = DYTC_MODE_QUIET;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		*perfmode = DYTC_MODE_BALANCE;
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		*perfmode = DYTC_MODE_PERFORM;
+		break;
+	default: /* Unknown profile */
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+/*
+ * dytc_profile_get: Function to register with platform_profile
+ * handler. Returns current platform profile.
+ */
+int dytc_profile_get(void *data, enum platform_profile_option *profile)
+{
+	struct ideapad_private *priv = data;
+
+	*profile = priv->dytc->current_profile;
+	return 0;
+}
+
+/*
+ * Helper function - check if we are in CQL mode and if we are
+ *  -  disable CQL,
+ *  - run the command
+ *  - enable CQL
+ *  If not in CQL mode, just run the command
+ */
+int dytc_cql_command(struct ideapad_private *priv, int command, int *output)
+{
+	int err, cmd_err, dummy;
+	int cur_funcmode;
+
+	/* Determine if we are in CQL mode. This alters the commands we do */
+	err = method_dytc(priv->adev->handle, DYTC_CMD_GET, output);
+	if (err)
+		return err;
+
+	cur_funcmode = (*output >> DYTC_GET_FUNCTION_BIT) & 0xF;
+	/* Check if we're OK to return immediately */
+	if ((command == DYTC_CMD_GET) && (cur_funcmode != DYTC_FUNCTION_CQL))
+		return 0;
+
+	if (cur_funcmode == DYTC_FUNCTION_CQL) {
+		err = method_dytc(priv->adev->handle, DYTC_DISABLE_CQL, &dummy);
+		if (err)
+			return err;
+	}
+
+	cmd_err = method_dytc(priv->adev->handle, command,	output);
+	/* Check return condition after we've restored CQL state */
+
+	if (cur_funcmode == DYTC_FUNCTION_CQL) {
+		err = method_dytc(priv->adev->handle, DYTC_ENABLE_CQL, &dummy);
+		if (err)
+			return err;
+	}
+
+	return cmd_err;
+}
+
+/*
+ * dytc_profile_set: Function to register with platform_profile
+ * handler. Sets current platform profile.
+ */
+int dytc_profile_set(void *data, enum platform_profile_option profile)
+{
+	struct ideapad_private *priv = data;
+	int output;
+	int err;
+
+	err = mutex_lock_interruptible(&priv->dytc->mutex);
+	if (err)
+		return err;
+
+	if (profile == PLATFORM_PROFILE_BALANCED) {
+		/* To get back to balanced mode we just issue a reset command */
+		err = method_dytc(priv->adev->handle, DYTC_CMD_RESET, &output);
+		if (err)
+			goto unlock;
+	} else {
+		int perfmode;
+
+		err = convert_profile_to_dytc(profile, &perfmode);
+		if (err)
+			goto unlock;
+
+		/* Determine if we are in CQL mode. This alters the commands we do */
+		err = dytc_cql_command(priv,
+				DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1),
+				&output);
+		if (err)
+			goto unlock;
+	}
+	/* Success - update current profile */
+	priv->dytc->current_profile = profile;
+unlock:
+	mutex_unlock(&priv->dytc->mutex);
+	return err;
+}
+
+static void dytc_profile_refresh(struct ideapad_private *priv)
+{
+	enum platform_profile_option profile;
+	int output, err;
+	int perfmode;
+
+	mutex_lock(&priv->dytc->mutex);
+	err = dytc_cql_command(priv, DYTC_CMD_GET, &output);
+	mutex_unlock(&priv->dytc->mutex);
+	if (err)
+		return;
+
+	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
+	convert_dytc_to_profile(perfmode, &profile);
+	if (profile != priv->dytc->current_profile) {
+		priv->dytc->current_profile = profile;
+		platform_profile_notify();
+	}
+}
+
+static int ideapad_dytc_profile_init(struct ideapad_private *priv)
+{
+	int err, output, dytc_version;
+
+	err = method_dytc(priv->adev->handle, DYTC_CMD_QUERY, &output);
+	/* For all other errors we can flag the failure */
+	if (err)
+		return err;
+
+	/* Check DYTC is enabled and supports mode setting */
+	if (!(output & BIT(DYTC_QUERY_ENABLE_BIT)))
+		return -ENODEV;
+
+	dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
+	if (dytc_version < 5)
+		return -ENODEV;
+
+	priv->dytc = kzalloc(sizeof(struct ideapad_dytc_priv), GFP_KERNEL);
+	if (!priv->dytc)
+		return -ENOMEM;
+
+	mutex_init(&priv->dytc->mutex);
+
+	priv->dytc->handler.data = priv;
+	priv->dytc->handler.profile_get = dytc_profile_get;
+	priv->dytc->handler.profile_set = dytc_profile_set;
+
+	/* Setup supported modes */
+	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->handler.choices);
+
+	/* Create platform_profile structure and register */
+	err = platform_profile_register(&priv->dytc->handler);
+	if (err)
+		goto mutex_destroy;
+
+	/* Ensure initial values are correct */
+	dytc_profile_refresh(priv);
+
+	return 0;
+
+mutex_destroy:
+	mutex_destroy(&priv->dytc->mutex);
+	kfree(priv->dytc);
+	priv->dytc = NULL;
+	return err;
+}
+
+static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
+{
+	if (!priv->dytc)
+		return;
+
+	platform_profile_remove();
+	mutex_destroy(&priv->dytc->mutex);
+	kfree(priv->dytc);
+	priv->dytc = NULL;
+}
+
 /*
  * Rfkill
  */
@@ -1013,6 +1287,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	ideapad_sync_rfk_state(priv);
 	ideapad_sync_touchpad_state(priv);
 
+	ideapad_dytc_profile_init(priv);
+
 	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		ret = ideapad_backlight_init(priv);
 		if (ret && ret != -ENODEV)
@@ -1066,6 +1342,7 @@ static int ideapad_acpi_remove(struct platform_device *pdev)
 	acpi_remove_notify_handler(priv->adev->handle,
 		ACPI_DEVICE_NOTIFY, ideapad_acpi_notify);
 	ideapad_backlight_exit(priv);
+	ideapad_dytc_profile_exit(priv);
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
 		ideapad_unregister_rfkill(priv, i);
 	ideapad_input_exit(priv);
@@ -1087,6 +1364,10 @@ static int ideapad_acpi_resume(struct device *device)
 
 	ideapad_sync_rfk_state(priv);
 	ideapad_sync_touchpad_state(priv);
+
+	if (priv->dytc)
+		dytc_profile_refresh(priv);
+
 	return 0;
 }
 #endif
-- 
2.30.0

