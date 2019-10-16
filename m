Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A4D8A69
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbfJPIB0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 04:01:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:50904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730874AbfJPIB0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 04:01:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 01:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="202005424"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2019 01:01:22 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKeFF-0006Vq-V4; Wed, 16 Oct 2019 11:01:21 +0300
Date:   Wed, 16 Oct 2019 11:01:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 13/14] platform/x86: intel_cht_int33fe: use inline
 reference properties
Message-ID: <20191016080121.GQ32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-14-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-14-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:20PM -0700, Dmitry Torokhov wrote:
> Now that static device properties allow defining reference properties
> together with all other types of properties, instead of managing them
> separately, let's adjust the driver.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

as an idea, whatever implementation we will settle on.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 81 ++++++++++++------------
>  1 file changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 1d5d877b9582..4177c5424931 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -46,30 +46,6 @@ struct cht_int33fe_data {
>  	struct fwnode_handle *dp;
>  };
>  
> -static const struct software_node nodes[];
> -
> -static const struct software_node_ref_args pi3usb30532_ref = {
> -	&nodes[INT33FE_NODE_PI3USB30532]
> -};
> -
> -static const struct software_node_ref_args dp_ref = {
> -	&nodes[INT33FE_NODE_DISPLAYPORT]
> -};
> -
> -static struct software_node_ref_args mux_ref;
> -
> -static const struct software_node_reference usb_connector_refs[] = {
> -	{ "orientation-switch", 1, &pi3usb30532_ref},
> -	{ "mode-switch", 1, &pi3usb30532_ref},
> -	{ "displayport", 1, &dp_ref},
> -	{ }
> -};
> -
> -static const struct software_node_reference fusb302_refs[] = {
> -	{ "usb-role-switch", 1, &mux_ref},
> -	{ }
> -};
> -
>  /*
>   * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
>   * the max17047 both through the INT33FE ACPI device (it is right there
> @@ -105,8 +81,18 @@ static const struct property_entry max17047_props[] = {
>  	{ }
>  };
>  
> +/*
> + * We are not using inline property here because those are constant,
> + * and we need to adjust this one at runtime to point to real
> + * software node.
> + */
> +static struct software_node_ref_args fusb302_mux_refs[] = {
> +	{ .node = NULL },
> +};
> +
>  static const struct property_entry fusb302_props[] = {
>  	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
> +	PROPERTY_ENTRY_REF_ARRAY("usb-role-switch", fusb302_mux_refs),
>  	{ }
>  };
>  
> @@ -122,6 +108,8 @@ static const u32 snk_pdo[] = {
>  	PDO_VAR(5000, 12000, 3000),
>  };
>  
> +static const struct software_node nodes[];
> +
>  static const struct property_entry usb_connector_props[] = {
>  	PROPERTY_ENTRY_STRING("data-role", "dual"),
>  	PROPERTY_ENTRY_STRING("power-role", "dual"),
> @@ -129,15 +117,21 @@ static const struct property_entry usb_connector_props[] = {
>  	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
>  	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
>  	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
> +	PROPERTY_ENTRY_REF("orientation-switch",
> +			   &nodes[INT33FE_NODE_PI3USB30532]),
> +	PROPERTY_ENTRY_REF("mode-switch",
> +			   &nodes[INT33FE_NODE_PI3USB30532]),
> +	PROPERTY_ENTRY_REF("displayport",
> +			   &nodes[INT33FE_NODE_DISPLAYPORT]),
>  	{ }
>  };
>  
>  static const struct software_node nodes[] = {
> -	{ "fusb302", NULL, fusb302_props, fusb302_refs },
> +	{ "fusb302", NULL, fusb302_props },
>  	{ "max17047", NULL, max17047_props },
>  	{ "pi3usb30532" },
>  	{ "displayport" },
> -	{ "connector", &nodes[0], usb_connector_props, usb_connector_refs },
> +	{ "connector", &nodes[0], usb_connector_props },
>  	{ }
>  };
>  
> @@ -173,9 +167,10 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>  {
>  	software_node_unregister_nodes(nodes);
>  
> -	if (mux_ref.node) {
> -		fwnode_handle_put(software_node_fwnode(mux_ref.node));
> -		mux_ref.node = NULL;
> +	if (fusb302_mux_refs[0].node) {
> +		fwnode_handle_put(
> +			software_node_fwnode(fusb302_mux_refs[0].node));
> +		fusb302_mux_refs[0].node = NULL;
>  	}
>  
>  	if (data->dp) {
> @@ -187,25 +182,31 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>  
>  static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>  {
> +	const struct software_node *mux_ref_node;
>  	int ret;
>  
> -	ret = software_node_register_nodes(nodes);
> -	if (ret)
> -		return ret;
> -
> -	/* The devices that are not created in this driver need extra steps. */
> -
>  	/*
>  	 * There is no ACPI device node for the USB role mux, so we need to wait
>  	 * until the mux driver has created software node for the mux device.
>  	 * It means we depend on the mux driver. This function will return
>  	 * -EPROBE_DEFER until the mux device is registered.
>  	 */
> -	mux_ref.node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
> -	if (!mux_ref.node) {
> -		ret = -EPROBE_DEFER;
> -		goto err_remove_nodes;
> -	}
> +	mux_ref_node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
> +	if (!mux_ref_node)
> +		return -EPROBE_DEFER;
> +
> +	/*
> +	 * Update node used in "usb-role-switch" property. Note that we
> +	 * rely on software_node_register_nodes() to use the original
> +	 * instance of properties instead of copying them.
> +	 */
> +	fusb302_mux_refs[0].node = mux_ref_node;
> +
> +	ret = software_node_register_nodes(nodes);
> +	if (ret)
> +		return ret;
> +
> +	/* The devices that are not created in this driver need extra steps. */
>  
>  	/*
>  	 * The DP connector does have ACPI device node. In this case we can just
> -- 
> 2.23.0.700.g56cf767bdb-goog
> 

-- 
With Best Regards,
Andy Shevchenko


