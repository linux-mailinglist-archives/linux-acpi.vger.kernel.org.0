Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920DC2DEAF3
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 22:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLRVSY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 16:18:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:7349 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgLRVSX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Dec 2020 16:18:23 -0500
IronPort-SDR: 0JlXCvVjgfsoWdCkWc+crPUKsgFfAZXkhNOfuhArg3ndisLVIDt538iaivQjCGtXtEEUUczPsJ
 ypcieFNS4ztg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="239594709"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="239594709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 13:16:37 -0800
IronPort-SDR: lwuxQtHx/+Vpq5uEJsaOw+jbynHL+Ge8PzNhREvzAbT2cFe/2Q1U6R+67rUR1fg94uizmYxZKw
 G6y9vmnJBgmw==
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="454289544"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 13:16:31 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kqN80-00FgnK-M6; Fri, 18 Dec 2020 23:17:32 +0200
Date:   Fri, 18 Dec 2020 23:17:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
Message-ID: <20201218211732.GE4077@smile.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-13-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-13-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 17, 2020 at 11:43:37PM +0000, Daniel Scally wrote:
> Currently on platforms designed for Windows, connections between CIO2 and
> sensors are not properly defined in DSDT. This patch extends the ipu3-cio2
> driver to compensate by building software_node connections, parsing the
> connection properties from the sensor's SSDB buffer.

...

> +	sensor->ep_properties[0] = PROPERTY_ENTRY_U32(sensor->prop_names.bus_type, 4);

Does 4 has any meaning that can be described by #define ?

...

> +static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
> +{
> +	snprintf(sensor->node_names.remote_port, 7, "port@%u", sensor->ssdb.link);

Hmm... I think you should use actual size of remote_port instead of 7.

> +	strscpy(sensor->node_names.port, "port@0", sizeof(sensor->node_names.port));

Yeah, I would rather like to see one point of the definition of the format.
If it's the same as per OF case, perhaps some generic header (like fwnode.h?) is good for this?
In this case the 5 in one of the previous patches Also can be derived from the format.

> +	strscpy(sensor->node_names.endpoint, "endpoint@0", sizeof(sensor->node_names.endpoint));

Similar here.

> +}

...

> +	for (i = 0; i < ARRAY_SIZE(cio2_supported_sensors); i++) {
> +		const struct cio2_sensor_config *cfg = &cio2_supported_sensors[i];
> +
> +		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {

> +			if (bridge->n_sensors >= CIO2_NUM_PORTS) {
> +				dev_warn(&cio2->dev, "Exceeded available CIO2 ports\n");

> +				/* overflow i so outer loop ceases */
> +				i = ARRAY_SIZE(cio2_supported_sensors);
> +				break;

Why not to create a new label below and assign ret here with probably comment
why it's not an error?

> +			}

...

> +			ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
> +							   &sensor->ssdb,
> +							   sizeof(sensor->ssdb));
> +			if (ret < 0)

if (ret) (because positive case can be returned just by next conditional).

> +				goto err_put_adev;
> +
> +			if (sensor->ssdb.lanes > 4) {
> +				dev_err(&adev->dev,
> +					"Number of lanes in SSDB is invalid\n");
> +				goto err_put_adev;
> +			}

...

> +			dev_info(&cio2->dev, "Found supported sensor %s\n",
> +				 acpi_dev_name(adev));
> +
> +			bridge->n_sensors++;
> +		}
> +	}

	return 0;

> +err_free_swnodes:
> +	software_node_unregister_nodes(sensor->swnodes);
> +err_put_adev:
> +	acpi_dev_put(sensor->adev);

err_out:

> +	return ret;
> +}

...

> +enum cio2_sensor_swnodes {
> +	SWNODE_SENSOR_HID,
> +	SWNODE_SENSOR_PORT,
> +	SWNODE_SENSOR_ENDPOINT,
> +	SWNODE_CIO2_PORT,
> +	SWNODE_CIO2_ENDPOINT,

> +	NR_OF_SENSOR_SWNODES

Perhaps same namespace, i.e.

	SWNODE_SENSOR_NR

> +};

-- 
With Best Regards,
Andy Shevchenko


