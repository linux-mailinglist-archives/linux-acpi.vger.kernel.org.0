Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC031680D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 14:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhBJNce (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 08:32:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41634 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBJNce (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 08:32:34 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id fef06e97a1c7c808; Wed, 10 Feb 2021 14:31:49 +0100
Received: from kreacher.localnet (89-64-80-225.dynamic.chello.pl [89.64.80.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E0A5E6608FC;
        Wed, 10 Feb 2021 14:31:48 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Subject: Re: [PATCH v1 7/7] ACPI: property: Allow counting a single value as an array of 1 element
Date:   Wed, 10 Feb 2021 14:31:48 +0100
Message-ID: <3881654.NPl3a4M0kB@kreacher>
In-Reply-To: <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com> <20210210114320.3478-7-andriy.shevchenko@linux.intel.com> <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfelheffhfetffelhfelteejffetteetgfetkeejvdfhfeeftdeufeevgeevieevnecukfhppeekledrieegrdektddrvddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrvddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghl
 rdhorhhgpdhrtghpthhtoheptggrlhhvihhnrdhjohhhnhhsohhnsehoshhsrdhngihprdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, February 10, 2021 1:36:00 PM CET Rafael J. Wysocki wrote:
> On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > We allow to read the single value as a first element in the array.
> > Unfortunately the counting doesn't work in this case and we can't
> > call fwnode_property_count_*() API without getting an error.
> 
> It would be good to mention what the symptom of the issue is here.
> 
> > Modify acpi_data_prop_read() to always try the single value read
> > and thus allow counting the single value as an array of 1 element.
> >
> > Reported-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This is a bug fix, so it should go in before the cleanups in this series IMO.
> 
> Also it looks like stable@vger material.
> 
> > ---
> >  drivers/acpi/property.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 236316ee0e25..d6100585fceb 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -913,12 +913,14 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
> >         const union acpi_object *items;
> >         int ret;
> >
> > -       if (val && nval == 1) {
> > +       /* Try to read as a single value first */
> > +       if (!val || nval == 1) {
> >                 ret = acpi_data_prop_read_single(data, propname, proptype, val);
> 
> This returns -EINVAL if val is NULL.
> 
> >                 if (ret >= 0)
> > -                       return ret;
> > +                       return val ? ret : 1;
> 
> So val cannot be NULL here.
> 
> >         }
> >
> > +       /* It's not the single value, get an array instead */
> >         ret = acpi_data_get_property_array(data, propname, ACPI_TYPE_ANY, &obj);
> >         if (ret)
> >                 return ret;
> > --
> 
> To me, acpi_fwnode_property_read_string_array() needs to special-case
> val == NULL and nval == 0.

Well, scratch this.

Something like the patch below (untested) should be sufficient to address this
if I'm not mistaken.

---
 drivers/acpi/property.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -787,14 +787,14 @@ static int acpi_data_prop_read_single(co
 	const union acpi_object *obj;
 	int ret;
 
-	if (!val)
-		return -EINVAL;
-
 	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64) {
 		ret = acpi_data_get_property(data, propname, ACPI_TYPE_INTEGER, &obj);
 		if (ret)
 			return ret;
 
+		if (!val)
+			return 1;
+
 		switch (proptype) {
 		case DEV_PROP_U8:
 			if (obj->integer.value > U8_MAX)
@@ -820,7 +820,8 @@ static int acpi_data_prop_read_single(co
 		if (ret)
 			return ret;
 
-		*(char **)val = obj->string.pointer;
+		if (val)
+			*(char **)val = obj->string.pointer;
 
 		return 1;
 	} else {
@@ -928,10 +929,16 @@ static int acpi_data_prop_read(const str
 	const union acpi_object *items;
 	int ret;
 
-	if (val && nval == 1) {
+	if (nval == 1) {
 		ret = acpi_data_prop_read_single(data, propname, proptype, val);
 		if (ret >= 0)
 			return ret;
+
+		/*
+		 * Reading this property as a single-value one failed, but its
+		 * value may still be represented as one-element array, so
+		 * continue.
+		 */
 	}
 
 	ret = acpi_data_get_property_array(data, propname, ACPI_TYPE_ANY, &obj);




