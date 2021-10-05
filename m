Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3691C4222AD
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhJEJwd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 05:52:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:64710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEJwc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 05:52:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="212820242"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="diff'?scan'208";a="212820242"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 02:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="diff'?scan'208";a="623338529"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 Oct 2021 02:50:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 05 Oct 2021 12:50:38 +0300
Date:   Tue, 5 Oct 2021 12:50:38 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <YVwf7uzL1aydysVl@kuha.fi.intel.com>
References: <YVrM8VdLKZUt0i8R@kroah.com>
 <20211004121942.GA3343713@sol>
 <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
 <20211004124701.GA3418302@sol>
 <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
 <20211004141754.GA3510607@sol>
 <20211004152844.GA3825382@sol>
 <CAHp75VeBc3AN+5f680LeK8V6NpiiaPUTgE14FFonUM1W-xrjNA@mail.gmail.com>
 <20211005004035.GA29779@sol>
 <YVwLIWrqY9TRLjwG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="E1rW6XjjgdukUFBO"
Content-Disposition: inline
In-Reply-To: <YVwLIWrqY9TRLjwG@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--E1rW6XjjgdukUFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 05, 2021 at 11:21:53AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 05, 2021 at 08:40:35AM +0800, Kent Gibson wrote:
> > On Mon, Oct 04, 2021 at 10:56:00PM +0300, Andy Shevchenko wrote:
> > > On Mon, Oct 4, 2021 at 8:51 PM Kent Gibson <warthog618@gmail.com> wrote:
> 
> ...
> 
> > > Here is debug prints of what happens
> > > 
> > > # modprobe gpio-mockup gpio_mockup_ranges=-1,10
> > > [  212.850993]  (null): device_create_managed_software_node <<< 0
> > > [  212.858177] platform gpio-mockup.0: software_node_notify 0 <<<
> > > [  212.865264] platform gpio-mockup.0: software_node_notify 1 <<< 1
> > > [  212.874159] gpio-mockup gpio-mockup.0: no of_node; not parsing pinctrl DT
> > > [  212.882962] gpiochip_find_base: found new base at 840
> > > [  212.889873] gpio gpiochip3: software_node_notify 0 <<<
> > > [  212.896164] gpio gpiochip3: software_node_notify 1 <<< 1
> > > [  212.905099] gpio gpiochip3: (gpio-mockup-A): added GPIO chardev (254:3)
> > > [  212.913313] gpio gpiochip840: software_node_notify 0 <<<
> > > [  212.920676] gpio gpiochip3: registered GPIOs 840 to 849 on gpio-mockup-A
> > > [  212.935601] modprobe (185) used greatest stack depth: 12744 bytes left
> > > 
> > > As I read it the software node is created for gpio-mockup device and
> > > then _shared_ with the GPIO device, since it's managed it's gone when
> > > GPIO device gone followed by UAF when mockup (platform) device itself
> > > gone. I.o.w. this software node mustn't be managed because it covers
> > > the lifetime of two different objects. The correct fix is to create
> > > manually software node and assign it to the pdev and manually free in
> > > gpio_mockup_unregister_pdevs()/
> > > 
> > > Tl;DR: it's a bug in gpio-mockup.
> > 
> > So the bug is in the behaviour of gpio_mockup_register_chip()?
> 
> Not really. The utter root cause is the former API (device_add_properties()
> et al) which Heikki is getting rid of in particular because of this issue,
> i.e. when users blindly call it without fully understanding the picture of
> the object lifetimes.
> 
> > That is out of my court, so I'll leave it to you and Bart to sort out.
> 
> I'll see what I can do about.

So, something like this (attached)?

-- 
heikki

--E1rW6XjjgdukUFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gpio-mockup.diff"

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 0a9d746a0fe0a..469f3cbfd6b05 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -476,10 +476,22 @@ static struct platform_device *gpio_mockup_pdevs[GPIO_MOCKUP_MAX_GC];
 
 static void gpio_mockup_unregister_pdevs(void)
 {
+	struct software_node *swnode;
 	int i;
 
-	for (i = 0; i < GPIO_MOCKUP_MAX_GC; i++)
+	for (i = 0; i < GPIO_MOCKUP_MAX_GC; i++) {
+		swnode = to_software_node(gpio_mockup_pdevs[i].dev.fwnode);
+
+		/*
+		 * Note. The software node must be unregistered before the
+		 * device to prevent the device_remove_properties() call in
+		 * device_del() from causing ref count underflow.
+		 */
+		software_node_unregister(swnode);
 		platform_device_unregister(gpio_mockup_pdevs[i]);
+		property_entries_free(swnode->properties);
+		kfree(swnode);
+	}
 }
 
 static __init char **gpio_mockup_make_line_names(const char *label,
@@ -508,9 +520,11 @@ static int __init gpio_mockup_register_chip(int idx)
 	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
 	struct platform_device_info pdevinfo;
 	struct platform_device *pdev;
+	struct software_node *swnode;
 	char **line_names = NULL;
 	char chip_label[32];
 	int prop = 0, base;
+	int ret = -ENOMEM;
 	u16 ngpio;
 
 	memset(properties, 0, sizeof(properties));
@@ -536,20 +550,47 @@ static int __init gpio_mockup_register_chip(int idx)
 					"gpio-line-names", line_names, ngpio);
 	}
 
+	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
+	if (!swnode)
+		goto err_free_line_names;
+
+	swnode->properties = property_entry_dup(properties);
+	if (!swnode->properties)
+		goto err_free_swnode;
+
+	ret = software_node_register(swnode);
+	if (ret)
+		goto err_free_properties;
+
 	pdevinfo.name = "gpio-mockup";
 	pdevinfo.id = idx;
-	pdevinfo.properties = properties;
+	pdevinfo.fwnode = software_node_fwnode(swnode);
 
 	pdev = platform_device_register_full(&pdevinfo);
 	kfree_strarray(line_names, ngpio);
 	if (IS_ERR(pdev)) {
 		pr_err("error registering device");
-		return PTR_ERR(pdev);
+		ret = PTR_ERR(pdev);
+		goto err_unregister_swnode;
 	}
 
 	gpio_mockup_pdevs[idx] = pdev;
 
 	return 0;
+
+err_unregister_swnode:
+	software_node_unregister(swnode);
+
+err_free_properties:
+	property_entries_free(swnode->properties);
+
+err_free_swnode:
+	kfree(swnode);
+
+err_free_line_names:
+	kfree_strarray(line_names, ngpio);
+
+	return ret;
 }
 
 static int __init gpio_mockup_init(void)

--E1rW6XjjgdukUFBO--
