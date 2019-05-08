Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4246D17716
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2019 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfEHLaY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 May 2019 07:30:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:53036 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfEHLaW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 May 2019 07:30:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 04:30:21 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 May 2019 04:30:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 May 2019 14:30:17 +0300
Date:   Wed, 8 May 2019 14:30:17 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 11/13] platform/x86: intel_cht_int33fe: Provide fwnode
 for the USB connector
Message-ID: <20190508113017.GC19816@kuha.fi.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-12-heikki.krogerus@linux.intel.com>
 <daed3557-7595-86c5-fde1-6ec048b0935d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daed3557-7595-86c5-fde1-6ec048b0935d@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 17, 2019 at 11:52:00AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 12-04-19 15:41, Heikki Krogerus wrote:
> > In ACPI, and now also in DT, the USB connectors usually have
> > their own device nodes. In case of USB Type-C, those
> > connector (port) nodes are child nodes of the controller or
> > PHY device, in our case the fusb302. The software fwnodes
> > allow us to create a similar child node for fusb302 that
> > represents the connector also on Intel CHT.
> > 
> > This makes it possible replace the fusb302 specific device
> > properties which were deprecated with the common USB
> > connector properties that tcpm.c is able to use directly.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >   drivers/platform/x86/intel_cht_int33fe.c | 37 ++++++++++++++++++++++--
> >   1 file changed, 34 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> > index 863a792d9282..eff5990322ff 100644
> > --- a/drivers/platform/x86/intel_cht_int33fe.c
> > +++ b/drivers/platform/x86/intel_cht_int33fe.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/platform_device.h>
> >   #include <linux/regulator/consumer.h>
> >   #include <linux/slab.h>
> > +#include <linux/usb/pd.h>
> >   #define EXPECTED_PTYPE		4
> > @@ -31,6 +32,7 @@ enum {
> >   	INT33FE_NODE_FUSB302,
> >   	INT33FE_NODE_MAX17047,
> >   	INT33FE_NODE_PI3USB30532,
> > +	INT33FE_NODE_USB_CONNECTOR,
> >   	INT33FE_NODE_MAX,
> >   };
> > @@ -111,9 +113,29 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
> >   static const struct property_entry fusb302_props[] = {
> >   	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
> > -	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
> > -	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
> > -	PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),
> 
> Note that the 36000000 value being removed here is max-sink-microwatt,
> esp. the _max_ part is important. And recent versions of the fusb302
> code ignore this entirely.
> 
> > +	{ }
> > +};
> > +
> > +#define PDO_FIXED_FLAGS \
> > +	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
> > +
> > +static const u32 src_pdo[] = {
> > +	PDO_FIXED(5000, 1500, PDO_FIXED_FLAGS),
> > +};
> > +
> > +static const u32 snk_pdo[] = {
> > +	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
> > +	PDO_VAR(5000, 12000, 3000),
> > +};
> > +
> > +static const struct property_entry usb_connector_props[] = {
> > +	PROPERTY_ENTRY_STRING("name", "connector"),
> > +	PROPERTY_ENTRY_STRING("data-role", "dual"),
> > +	PROPERTY_ENTRY_STRING("power-role", "dual"),
> > +	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
> > +	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
> > +	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> > +	PROPERTY_ENTRY_U32("op-sink-microwatt", 36000000),
> 
> Where as "op-sink-microwatt" is more interpreted as a minimum
> value for non PPS supplies not being able to deliver this causes
> the Capability Mismatch to get set. But for PPS supplies if I'm
> reading the code correctly, the entire PPS negotiation is failed
> by tcpm.c if this cannot be matched. I guess / hope that there
> is a fallback to none PPS PDOs then but I'm not sure.

OK. I'll change that to the current default value, 2500000.

> Anyways the charger the GPD-win ships with is a non PD capable
> 5V/2A charger and the GPD-pocket ships with a charger which does
> max 12V/2A. The device itself will work fine on around 10W and
> even charge at that level (albeit slowly). So I believe that 10W
> would be a better value for "op-sink-microwatt" (the dt-binding
> says it is mandatory so we cannot just leave it out).

I have no objections. If you prefer, I can include a separate patch
where I change the value to 10W.

thanks,

-- 
heikki
