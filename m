Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4816924BA
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjBJRl2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 12:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjBJRlX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 12:41:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96D7A7D0;
        Fri, 10 Feb 2023 09:41:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD1BP4Wt4z67Qtq;
        Sat, 11 Feb 2023 01:36:45 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 17:41:14 +0000
Date:   Fri, 10 Feb 2023 17:41:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 12/20] cxl/port: Split endpoint and switch port probe
Message-ID: <20230210174113.000079d0@Huawei.com>
In-Reply-To: <167601999378.1924368.15071142145866277623.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167601999378.1924368.15071142145866277623.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.211]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 10 Feb 2023 01:06:33 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan points out that the shared code between the switch and endpoint
> case is small. Before adding another is_cxl_endpoint() conditional,
> just split the two cases.
> 
> Rather than duplicate the "Couldn't enumerate decoders" error message
> take the opportunity to improve the error messages in
> devm_cxl_enumerate_decoders().
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Link: http://lore.kernel.org/r/20230208170724.000067ec@Huawei.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c |   11 ++++++--
>  drivers/cxl/port.c     |   69 +++++++++++++++++++++++++++---------------------
>  2 files changed, 47 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index dcc16d7cb8f3..a0891c3464f1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -826,7 +826,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			cxled = cxl_endpoint_decoder_alloc(port);
>  			if (IS_ERR(cxled)) {
>  				dev_warn(&port->dev,
> -					 "Failed to allocate the decoder\n");
> +					 "Failed to allocate decoder%d.%d\n",
> +					 port->id, i);
>  				return PTR_ERR(cxled);
>  			}
>  			cxld = &cxled->cxld;
> @@ -836,7 +837,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			cxlsd = cxl_switch_decoder_alloc(port, target_count);
>  			if (IS_ERR(cxlsd)) {
>  				dev_warn(&port->dev,
> -					 "Failed to allocate the decoder\n");
> +					 "Failed to allocate decoder%d.%d\n",
> +					 port->id, i);
>  				return PTR_ERR(cxlsd);
>  			}
>  			cxld = &cxlsd->cxld;
> @@ -844,13 +846,16 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  
>  		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
>  		if (rc) {
> +			dev_warn(&port->dev,
> +				 "Failed to initialize decoder%d.%d\n",
> +				 port->id, i);
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
>  		rc = add_hdm_decoder(port, cxld, target_map);
>  		if (rc) {
>  			dev_warn(&port->dev,
> -				 "Failed to add decoder to port\n");
> +				 "Failed to add decoder%d.%d\n", port->id, i);
>  			return rc;
>  		}
>  	}
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..a8d46a67b45e 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,55 +30,64 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
>  
> -static int cxl_port_probe(struct device *dev)
> +static int cxl_switch_port_probe(struct cxl_port *port)
>  {
> -	struct cxl_port *port = to_cxl_port(dev);
>  	struct cxl_hdm *cxlhdm;
>  	int rc;
>  
> +	rc = devm_cxl_port_enumerate_dports(port);
> +	if (rc < 0)
> +		return rc;
>  
> -	if (!is_cxl_endpoint(port)) {
> -		rc = devm_cxl_port_enumerate_dports(port);
> -		if (rc < 0)
> -			return rc;
> -		if (rc == 1)
> -			return devm_cxl_add_passthrough_decoder(port);
> -	}
> +	if (rc == 1)
> +		return devm_cxl_add_passthrough_decoder(port);
>  
>  	cxlhdm = devm_cxl_setup_hdm(port);
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> -	if (is_cxl_endpoint(port)) {
> -		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> -		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	return devm_cxl_enumerate_decoders(cxlhdm);
> +}
>  
> -		/* Cache the data early to ensure is_visible() works */
> -		read_cdat_data(port);
> +static int cxl_endpoint_port_probe(struct cxl_port *port)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_hdm *cxlhdm;
> +	int rc;
> +
> +	cxlhdm = devm_cxl_setup_hdm(port);
> +	if (IS_ERR(cxlhdm))
> +		return PTR_ERR(cxlhdm);
>  
> -		get_device(&cxlmd->dev);
> -		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
> -		if (rc)
> -			return rc;
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
>  
> -		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
> -		if (rc)
> -			return rc;
> +	get_device(&cxlmd->dev);
> +	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
> +	if (rc)
> +		return rc;
>  
> -		rc = cxl_await_media_ready(cxlds);
> -		if (rc) {
> -			dev_err(dev, "Media not active (%d)\n", rc);
> -			return rc;
> -		}
> -	}
> +	rc = cxl_hdm_decode_init(cxlds, cxlhdm);
> +	if (rc)
> +		return rc;
>  
> -	rc = devm_cxl_enumerate_decoders(cxlhdm);
> +	rc = cxl_await_media_ready(cxlds);
>  	if (rc) {
> -		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
> +		dev_err(&port->dev, "Media not active (%d)\n", rc);
>  		return rc;
>  	}
>  
> -	return 0;
> +	return devm_cxl_enumerate_decoders(cxlhdm);
> +}
> +
> +static int cxl_port_probe(struct device *dev)
> +{
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	if (is_cxl_endpoint(port))
> +		return cxl_endpoint_port_probe(port);
> +	return cxl_switch_port_probe(port);
>  }
>  
>  static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
> 

