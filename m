Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B267498B6
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGFJuP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGFJuO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 05:50:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9301727;
        Thu,  6 Jul 2023 02:50:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363591223"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363591223"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="669697854"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="669697854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2023 02:50:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHLcl-000UE1-2Y;
        Thu, 06 Jul 2023 12:50:07 +0300
Date:   Thu, 6 Jul 2023 12:50:07 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 10/18] media: ipu-bridge: Add a parse_sensor_fwnode
 callback to ipu_bridge_init()
Message-ID: <ZKaOT0CpE8xVSBFo@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-11-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705213010.390849-11-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 05, 2023 at 11:30:02PM +0200, Hans de Goede wrote:
> Add a parse_sensor_fwnode() callback to ipu_bridge_init(), so that
> ipu_bridge_init() can be used with other sensor fwnode parse functions
> then just ipu_bridge_parse_ssdb().
> 
> This will allow the ipu3-bridge code to also be used by the atomisp
> driver.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Add ipu_parse_sensor_fwnode_t type for the callback function
> ---
>  drivers/media/pci/intel/ipu-bridge.c     | 10 ++++++----
>  drivers/media/pci/intel/ipu-bridge.h     | 11 +++++++++--
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c |  2 +-
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index 1f01f2c8b8a6..db67a75ae1b7 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -148,8 +148,7 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
>  	return orientation;
>  }
>  
> -static int ipu_bridge_parse_ssdb(struct acpi_device *adev,
> -				 struct ipu_sensor *sensor)
> +int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
>  {
>  	struct ipu_sensor_ssdb ssdb = {};
>  	int ret;
> @@ -179,6 +178,7 @@ static int ipu_bridge_parse_ssdb(struct acpi_device *adev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(ipu_bridge_parse_ssdb, INTEL_IPU_BRIDGE);
>  
>  static void ipu_bridge_create_fwnode_properties(
>  	struct ipu_sensor *sensor,
> @@ -343,7 +343,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
>  
>  		sensor = &bridge->sensors[bridge->n_sensors];
>  
> -		ret = ipu_bridge_parse_ssdb(adev, sensor);
> +		ret = bridge->parse_sensor_fwnode(adev, sensor);
>  		if (ret)
>  			goto err_put_adev;
>  
> @@ -441,7 +441,8 @@ static int ipu_bridge_sensors_are_ready(void)
>  	return ready;
>  }
>  
> -int ipu_bridge_init(struct device *dev)
> +int ipu_bridge_init(struct device *dev,
> +		    ipu_parse_sensor_fwnode_t parse_sensor_fwnode)
>  {
>  	struct fwnode_handle *fwnode;
>  	struct ipu_bridge *bridge;
> @@ -459,6 +460,7 @@ int ipu_bridge_init(struct device *dev)
>  		sizeof(bridge->ipu_node_name));
>  	bridge->ipu_hid_node.name = bridge->ipu_node_name;
>  	bridge->dev = dev;
> +	bridge->parse_sensor_fwnode = parse_sensor_fwnode;
>  
>  	ret = software_node_register(&bridge->ipu_hid_node);
>  	if (ret < 0) {
> diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
> index a8b89c4b95bc..7d84b22b2111 100644
> --- a/drivers/media/pci/intel/ipu-bridge.h
> +++ b/drivers/media/pci/intel/ipu-bridge.h
> @@ -140,8 +140,12 @@ struct ipu_sensor {
>  	struct software_node_ref_args vcm_ref[1];
>  };
>  
> +typedef int (*ipu_parse_sensor_fwnode_t)(struct acpi_device *adev,
> +					 struct ipu_sensor *sensor);
> +
>  struct ipu_bridge {
>  	struct device *dev;
> +	ipu_parse_sensor_fwnode_t parse_sensor_fwnode;
>  	char ipu_node_name[ACPI_ID_LEN];
>  	struct software_node ipu_hid_node;
>  	u32 data_lanes[4];
> @@ -150,9 +154,12 @@ struct ipu_bridge {
>  };
>  
>  #if IS_ENABLED(CONFIG_IPU_BRIDGE)
> -int ipu_bridge_init(struct device *dev);
> +int ipu_bridge_init(struct device *dev,
> +		    ipu_parse_sensor_fwnode_t parse_sensor_fwnode);
> +int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor);
>  #else
> -static inline int ipu_bridge_init(struct device *dev) { return 0; }
> +/* Use a define to avoid the @parse_sensor_fwnode argument getting evaluated */
> +#define ipu_bridge_init(dev, parse_sensor_fwnode)	(0)
>  #endif
>  
>  #endif
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> index 4068fa0a5ecf..26c4c1375990 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> @@ -1725,7 +1725,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
>  			return -EINVAL;
>  		}
>  
> -		r = ipu_bridge_init(dev);
> +		r = ipu_bridge_init(dev, ipu_bridge_parse_ssdb);
>  		if (r)
>  			return r;
>  	}
> -- 
> 2.41.0
> 

-- 
With Best Regards,
Andy Shevchenko


