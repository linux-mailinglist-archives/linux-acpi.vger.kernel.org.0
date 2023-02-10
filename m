Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF82692514
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjBJSMU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 13:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBJSMT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 13:12:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA73A0AC;
        Fri, 10 Feb 2023 10:12:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD1xd50LFz6J91l;
        Sat, 11 Feb 2023 02:10:45 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 18:12:14 +0000
Date:   Fri, 10 Feb 2023 18:12:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 14/20] tools/testing/cxl: Define a fixed volatile
 configuration to parse
Message-ID: <20230210181213.00001941@Huawei.com>
In-Reply-To: <167602000547.1924368.11613151863880268868.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167602000547.1924368.11613151863880268868.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 10 Feb 2023 01:06:45 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Take two endpoints attached to the first switch on the first host-bridge
> in the cxl_test topology and define a pre-initialized region. This is a
> x2 interleave underneath a x1 CXL Window.
> 
> $ modprobe cxl_test
> $ # cxl list -Ru
> {
>   "region":"region3",
>   "resource":"0xf010000000",
>   "size":"512.00 MiB (536.87 MB)",
>   "interleave_ways":2,
>   "interleave_granularity":4096,
>   "decode_state":"commit"
> }
> 
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564541523.847146.12199636368812381475.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
The few things I commented on v1 resolved so
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/core.h      |    3 -
>  drivers/cxl/core/hdm.c       |    3 +
>  drivers/cxl/core/port.c      |    2 +
>  drivers/cxl/cxl.h            |    2 +
>  drivers/cxl/cxlmem.h         |    3 +
>  tools/testing/cxl/test/cxl.c |  147 +++++++++++++++++++++++++++++++++++++++---
>  6 files changed, 146 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5eb873da5a30..479f01da6d35 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -57,9 +57,6 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  
> -bool is_switch_decoder(struct device *dev);
> -struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> -
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8c29026a4b9d..80eccae6ba9e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -279,7 +279,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> -static int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> +int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				resource_size_t base, resource_size_t len,
>  				resource_size_t skipped)
>  {
> @@ -295,6 +295,7 @@ static int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, CXL);
>  
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  {
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 59620528571a..b45d2796ef35 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -458,6 +458,7 @@ bool is_switch_decoder(struct device *dev)
>  {
>  	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
>  }
> +EXPORT_SYMBOL_NS_GPL(is_switch_decoder, CXL);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev)
>  {
> @@ -485,6 +486,7 @@ struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
>  		return NULL;
>  	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, CXL);
>  
>  static void cxl_ep_release(struct cxl_ep *ep)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c8ee4bb8cce6..2ac344235235 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -653,8 +653,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
> +struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  						unsigned int nr_targets,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c9da3c699a21..bf7d4c5c8612 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -81,6 +81,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  }
>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> +int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> +			 resource_size_t base, resource_size_t len,
> +			 resource_size_t skipped);
>  
>  static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  					 struct cxl_memdev *cxlmd)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 920bd969c554..5342f69d70d2 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -703,6 +703,142 @@ static int mock_decoder_reset(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> +static void default_mock_decoder(struct cxl_decoder *cxld)
> +{
> +	cxld->hpa_range = (struct range){
> +		.start = 0,
> +		.end = -1,
> +	};
> +
> +	cxld->interleave_ways = 1;
> +	cxld->interleave_granularity = 256;
> +	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
> +}
> +
> +static int first_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +	cxld = to_cxl_decoder(dev);
> +	if (cxld->id == 0)
> +		return 1;
> +	return 0;
> +}
> +
> +static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
> +{
> +	struct acpi_cedt_cfmws *window = mock_cfmws[0];
> +	struct platform_device *pdev = NULL;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_port *port, *iter;
> +	const int size = SZ_512M;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dport *dport;
> +	struct device *dev;
> +	bool hb0 = false;
> +	u64 base;
> +	int i;
> +
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +		cxlmd = cxled_to_memdev(cxled);
> +		WARN_ON(!dev_is_platform(cxlmd->dev.parent));
> +		pdev = to_platform_device(cxlmd->dev.parent);
> +
> +		/* check is endpoint is attach to host-bridge0 */
> +		port = cxled_to_port(cxled);
> +		do {
> +			if (port->uport == &cxl_host_bridge[0]->dev) {
> +				hb0 = true;
> +				break;
> +			}
> +			if (is_cxl_port(port->dev.parent))
> +				port = to_cxl_port(port->dev.parent);
> +			else
> +				port = NULL;
> +		} while (port);
> +		port = cxled_to_port(cxled);
> +	}
> +
> +	/*
> +	 * The first decoder on the first 2 devices on the first switch
> +	 * attached to host-bridge0 mock a fake / static RAM region. All
> +	 * other decoders are default disabled. Given the round robin
> +	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
> +	 *
> +	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
> +	 */
> +	if (!hb0 || pdev->id % 4 || pdev->id > 4 || cxld->id > 0) {
> +		default_mock_decoder(cxld);
> +		return;
> +	}
> +
> +	base = window->base_hpa;
> +	cxld->hpa_range = (struct range) {
> +		.start = base,
> +		.end = base + size - 1,
> +	};
> +
> +	cxld->interleave_ways = 2;
> +	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
> +	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->flags = CXL_DECODER_F_ENABLE;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +	port->commit_end = cxld->id;
> +	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
> +
> +	/*
> +	 * Now that endpoint decoder is set up, walk up the hierarchy
> +	 * and setup the switch and root port decoders targeting @cxlmd.
> +	 */
> +	iter = port;
> +	for (i = 0; i < 2; i++) {
> +		dport = iter->parent_dport;
> +		iter = dport->port;
> +		dev = device_find_child(&iter->dev, NULL, first_decoder);
> +		/*
> +		 * Ancestor ports are guaranteed to be enumerated before
> +		 * @port, and all ports have at least one decoder.
> +		 */
> +		if (WARN_ON(!dev))
> +			continue;
> +		cxlsd = to_cxl_switch_decoder(dev);
> +		if (i == 0) {
> +			/* put cxl_mem.4 second in the decode order */
> +			if (pdev->id == 4)
> +				cxlsd->target[1] = dport;
> +			else
> +				cxlsd->target[0] = dport;
> +		} else
> +			cxlsd->target[0] = dport;
> +		cxld = &cxlsd->cxld;
> +		cxld->target_type = CXL_DECODER_EXPANDER;
> +		cxld->flags = CXL_DECODER_F_ENABLE;
> +		iter->commit_end = 0;
> +		/*
> +		 * Switch targets 2 endpoints, while host bridge targets
> +		 * one root port
> +		 */
> +		if (i == 0)
> +			cxld->interleave_ways = 2;
> +		else
> +			cxld->interleave_ways = 1;
> +		cxld->interleave_granularity = 256;
> +		cxld->hpa_range = (struct range) {
> +			.start = base,
> +			.end = base + size - 1,
> +		};
> +		put_device(dev);
> +	}
> +}
> +
>  static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  {
>  	struct cxl_port *port = cxlhdm->port;
> @@ -748,16 +884,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			cxld = &cxled->cxld;
>  		}
>  
> -		cxld->hpa_range = (struct range) {
> -			.start = 0,
> -			.end = -1,
> -		};
> -
> -		cxld->interleave_ways = min_not_zero(target_count, 1);
> -		cxld->interleave_granularity = SZ_4K;
> -		cxld->target_type = CXL_DECODER_EXPANDER;
> -		cxld->commit = mock_decoder_commit;
> -		cxld->reset = mock_decoder_reset;
> +		mock_init_hdm_decoder(cxld);
>  
>  		if (target_count) {
>  			rc = device_for_each_child(port->uport, &ctx,
> 
> 

