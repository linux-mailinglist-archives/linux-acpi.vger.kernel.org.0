Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6730F36
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEaNqj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 09:46:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:15798 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaNqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 09:46:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 06:46:39 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2019 06:46:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 May 2019 16:46:35 +0300
Date:   Fri, 31 May 2019 16:46:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 13/16] platform/x86: intel_cht_int33fe: Provide
 software nodes for the devices
Message-ID: <20190531134635.GE7167@kuha.fi.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
 <20190522105113.11153-14-heikki.krogerus@linux.intel.com>
 <7468b83c-3d75-b43f-559b-68b3140a89e9@redhat.com>
 <9821910.95WSKUoubE@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9821910.95WSKUoubE@kreacher>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 31, 2019 at 11:10:31AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 29, 2019 11:30:58 AM CEST Hans de Goede wrote:
> > Hi,
> > 
> > On 5/22/19 12:51 PM, Heikki Krogerus wrote:
> > > Software nodes provide two features that we will need later.
> > > 1) Software nodes can have references to other software nodes.
> > > 2) Software nodes can exist before a device entry is created.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > ---
> > >   drivers/platform/x86/intel_cht_int33fe.c | 53 ++++++++++++++++++++----
> > >   1 file changed, 45 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> > > index 4ab47d6df413..a4ebd1d6b5b6 100644
> > > --- a/drivers/platform/x86/intel_cht_int33fe.c
> > > +++ b/drivers/platform/x86/intel_cht_int33fe.c
> > > @@ -27,6 +27,13 @@
> > >   
> > >   #define EXPECTED_PTYPE		4
> > >   
> > > +enum {
> > > +	INT33FE_NODE_FUSB302,
> > > +	INT33FE_NODE_MAX17047,
> > > +	INT33FE_NODE_PI3USB30532,
> > > +	INT33FE_NODE_MAX,
> > > +};
> > > +
> > >   struct cht_int33fe_data {
> > >   	struct i2c_client *max17047;
> > >   	struct i2c_client *fusb302;
> > > @@ -72,8 +79,13 @@ static const struct property_entry max17047_props[] = {
> > >   
> > >   static const struct property_entry fusb302_props[] = {
> > >   	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
> > > -	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
> > > -	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
> > > +	{ }
> > > +};
> > > +
> > > +static const struct software_node nodes[] = {
> > > +	{ "fusb302", NULL, fusb302_props },
> > > +	{ "max17047", NULL, max17047_props },
> > > +	{ "pi3usb30532" },
> > >   	{ }
> > >   };
> > >   
> > > @@ -82,14 +94,17 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
> > >   {
> > >   	struct i2c_client *max17047 = NULL;
> > >   	struct i2c_board_info board_info;
> > > +	struct fwnode_handle *fwnode;
> > >   	int ret;
> > >   
> > > +	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_MAX17047]);
> > > +	if (!fwnode)
> > > +		return -ENODEV;
> > > +
> > >   	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
> > >   	if (max17047) {
> > >   		/* Pre-existing i2c-client for the max17047, add device-props */
> > > -		ret = device_add_properties(&max17047->dev, max17047_props);
> > > -		if (ret)
> > > -			return ret;
> > > +		max17047->dev.fwnode->secondary = fwnode;
> > 
> > I believe that you should do:
> > 		fwnode->secondary = ERR_PTR(-ENODEV);
> > cht_int33fe_setup_dp
> > Before this call, as you are doing in the cht_int33fe_setup_dp function.
> 
> So I'm inclined to defer this patch until it is improved and queue up the rest of the series.
> 
> I can fix up the typo in the [15/16] while handling it.

Thanks Rafael. I'll send v5, and fix both in any case.

Cheers,

-- 
heikki
