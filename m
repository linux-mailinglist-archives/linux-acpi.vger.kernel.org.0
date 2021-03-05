Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D532E734
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 12:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhCEL0s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 06:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCEL0X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 06:26:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA25C061574
        for <linux-acpi@vger.kernel.org>; Fri,  5 Mar 2021 03:26:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso5990467pjk.0
        for <linux-acpi@vger.kernel.org>; Fri, 05 Mar 2021 03:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bU2r7z5kvgx1tqlWcZPBYiCcxdrBbMN2IbS+K3yntx0=;
        b=taPlnCakoVUQcYXRnyQ8JyhG8fzmnNLoORhE3ySpUJSOzfJHLisreta71wdvBg/TLo
         il452bcpzQHADaw0E6UUOADZHN1vr7Pi09nJYzN/Sc45XpVFEfVseBOyhu1d4/HYsIlj
         YAnJdZ0XlarMcQcW16GpCWFiZM/NHChnAByRYwZe1K60PMjxA2zxFxMLwA6N4LXWrPp6
         1CeRYRUVw6f7XWEV5BuaGDCb/l1LdP2r0WzdA0GISQvrgg9ng9VPJhFiO6EztoEEQNv/
         Yt3DLfyNf8/QXEMBuKv++xFEF/GVZeD2+hbEjaYFGHBzIpD/hJGGQc7njKaUqoSb99Qi
         ffig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bU2r7z5kvgx1tqlWcZPBYiCcxdrBbMN2IbS+K3yntx0=;
        b=P+lXoKNXOunTG0OOy40MUYwxnjj4IxyR+TEHaWQY7uhPwkit3pcwQEKPc0SDiKFbgU
         W15jmmul/kiQ2OTM7M512P53K1tEXyHFQgtdCPy5nB7Jvvn122mS2TiQ/2TAApkDkae1
         oeL5DHcfXjLmexz8EwjANLHhFqaPfz2EPZrp4HGmHAQTMESrpFcMIADhQOCc4MSNvXw0
         2x2qup3JqcRyx6dagUqSNXesHr1F5nVoiD1MZTeT6s1qTH2t1OmM+OF+YY1gyPcokoXa
         EFVDCk3D1N7NCduUFUMKp1Qnj3o8QU/BWooowdVTsETz4ACXoxXT73N9XOcM06+rxP3N
         4cjg==
X-Gm-Message-State: AOAM530jtcLSBPA3Vohd7nrhHuNnkJP20dDxv9PvPgY7RHD3i3Wph8Aq
        IDMlmS8f48evf8Oteq6GT8q6IQ==
X-Google-Smtp-Source: ABdhPJyaFRPUXJ01KFPSkqVioo9FwGFgTsVm1waulI64soJDvQL48WV5rlm1NuBRS4rkQrzZvkTjRA==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr9577559pjb.32.1614943582876;
        Fri, 05 Mar 2021 03:26:22 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id d16sm2005762pgb.12.2021.03.05.03.26.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Mar 2021 03:26:22 -0800 (PST)
Date:   Fri, 5 Mar 2021 19:26:16 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <20210305112614.GK17424@dragon>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <YD9bQXBD+9k3Lf/4@smile.fi.intel.com>
 <2ed0d4dc-2756-9a55-3f54-1377732e35fc@redhat.com>
 <20210305011429.GH17424@dragon>
 <f7aa417e-42b5-0c42-6f59-7311b060384f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7aa417e-42b5-0c42-6f59-7311b060384f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 05, 2021 at 10:10:50AM +0100, Hans de Goede wrote:
> > So we reach a consensus that this is not the right solution for Lenovo
> > Flex 5G. But what about for Andy's Galileo Gen 2 case, where the GPIO
> > number in ACPI is truly broken?
> 
> Well if the ACPI table truely simply has a wrong number in it, like in
> this case, then we clearly need a workaround.
> 
> >   ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
> 
> And we have one in place, so I'm not sure what the question is?
> 
> I guess the question is of your generic GPIO renumber patch would not
> be a better answer to that ?
> 
> IMHO no, we want to keep quirks out of the core as much as possible,
> for example the code which Andy added a quirk to is build as a module
> in the generic Fedora distro kernel, so for most users the code will
> not be loaded into memory. Where as if we add it to the core it would
> use up extra memory for everyone.

Fair point. I did not really think of it, because there is already
gpiolib_acpi_quirks[] in core code.  And on the other side, if there are
more drivers need such workaround, having each of these drivers copy the
same code is not ideal either.

> 
> Also if, in the future, we were to ever add a generic GPIO renumber quirk
> mechanism to the core, then your code would need more work. Because to be
> truely generic it would need to remap one gpiochip-name:pin-number on
> another gpiochip-name:pin-number pair. There might very well be a case
> with multiple gpiochips with pin number 32 being referenced in the DSDT
> and where we need to remap one of those 32-s to a different number
> (or possibly even to a different chip + number).

Yeah, I had already have v2 of my patch, just did not post it as the
overall direction is not agreed on.  I attach it here for discussion.
I think with the GPIO consumer specified, it should be good enough to
locate the broken GPIO number that needs override.  If gpiochip is
wrong, that means "\\_SB.GIO0" of GpioInt needs an override.  That's
a different issue.

GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
    "\\_SB.GIO0", 0x00, ResourceConsumer, ,
    )
    {   // Pin list
	0x0280
    }

Shawn


[PATCH v2] gpiolib: acpi: support override broken GPIO number in ACPI

Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
not working.  That's because the GpioInt number of TCPD node in ACPI
table is simply wrong, and the number even exceeds the maximum GPIO
lines.  As the touchpad works fine with Windows on the same machine,
presumably this is something Windows-ism.  Although it's obviously
a specification violation, believe of that Microsoft will fix this in
the near future is not really realistic.

It adds the support of overriding broken GPIO number in ACPI table
on particular machines, which are matched using DMI info.  Such
mechanism for fixing up broken firmware and ACPI table is not uncommon
in kernel.  And hopefully it can be useful for other machines that get
broken GPIO number coded in ACPI table.

The signature of acpi_get_gpiod() gets updated to pass over acpi_device
pointer of consumer device, so that the broken pin can be matched
precisely with consumer fwnode name.

Changes for v2:
- Match broken pin with additional consumer fwnode name comparison.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 79 +++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index e37a57d0a2f0..fed045d64a26 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -93,6 +93,72 @@ static DEFINE_MUTEX(acpi_gpio_deferred_req_irqs_lock);
 static LIST_HEAD(acpi_gpio_deferred_req_irqs_list);
 static bool acpi_gpio_deferred_req_irqs_done;
 
+struct acpi_gpio_pin_fixup {
+	const char *consumer;
+	int pin_broken;
+	int pin_correct;
+};
+
+struct acpi_gpio_pin_override {
+	const struct acpi_gpio_pin_fixup *fixups;
+	int num;
+};
+
+static const struct acpi_gpio_pin_fixup lenovo_flex_5g_fixups[] = {
+	{
+		/* GpioInt of Touchpad */
+		.consumer = "\\_SB.I2C8.TCPD",
+		.pin_broken = 0x0280,
+		.pin_correct = 0x0018,
+	},
+};
+
+static const struct acpi_gpio_pin_override lenovo_flex_5g_override = {
+	.fixups = lenovo_flex_5g_fixups,
+	.num = ARRAY_SIZE(lenovo_flex_5g_fixups),
+};
+
+static const struct dmi_system_id acpi_gpio_pin_override_table[] = {
+	{
+		.ident = "Lenovo Flex 5G",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_FAMILY, "Flex 5G 14Q8CX05"),
+		},
+		.driver_data = (void *)&lenovo_flex_5g_override,
+	},
+	{ } /* terminator */
+};
+
+static int acpi_gpio_pin_override(struct acpi_device *adev, int pin)
+{
+	const struct acpi_gpio_pin_override *override;
+	const struct dmi_system_id *system_id;
+	char *fwname;
+	int ret = pin;
+	int i;
+
+	system_id = dmi_first_match(acpi_gpio_pin_override_table);
+	if (!system_id)
+		return ret;
+
+	fwname = kasprintf(GFP_KERNEL, "%pfwf", &adev->fwnode);
+	override = system_id->driver_data;
+
+	for (i = 0; i < override->num; i++) {
+		const struct acpi_gpio_pin_fixup *f = &override->fixups[i];
+
+		if (!strcmp(f->consumer, fwname) && pin == f->pin_broken) {
+			ret = f->pin_correct;
+			goto done;
+		}
+	}
+
+done:
+	kfree(fwname);
+	return ret;
+}
+
 static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 {
 	if (!gc->parent)
@@ -103,6 +169,7 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 
 /**
  * acpi_get_gpiod() - Translate ACPI GPIO pin to GPIO descriptor usable with GPIO API
+ * @adev:	ACPI device that consumes the GPIO
  * @path:	ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
  * @pin:	ACPI GPIO pin number (0-based, controller-relative)
  *
@@ -111,7 +178,8 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
  * controller does not have GPIO chip registered at the moment. This is to
  * support probe deferral.
  */
-static struct gpio_desc *acpi_get_gpiod(char *path, int pin)
+static struct gpio_desc *acpi_get_gpiod(struct acpi_device *adev,
+					char *path, int pin)
 {
 	struct gpio_chip *chip;
 	acpi_handle handle;
@@ -125,7 +193,11 @@ static struct gpio_desc *acpi_get_gpiod(char *path, int pin)
 	if (!chip)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return gpiochip_get_desc(chip, pin);
+	/*
+	 * Give it a chance to correct the broken GPIO pin number in ACPI
+	 * table of particular machines.
+	 */
+	return gpiochip_get_desc(chip, acpi_gpio_pin_override(adev, pin));
 }
 
 static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
@@ -689,7 +761,8 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		if (pin_index >= agpio->pin_table_length)
 			return 1;
 
-		lookup->desc = acpi_get_gpiod(agpio->resource_source.string_ptr,
+		lookup->desc = acpi_get_gpiod(lookup->info.adev,
+					      agpio->resource_source.string_ptr,
 					      agpio->pin_table[pin_index]);
 		lookup->info.pin_config = agpio->pin_config;
 		lookup->info.debounce = agpio->debounce_timeout;
-- 
2.17.1

