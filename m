Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE146CCF47
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 03:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjC2BNq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 21:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2BNp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 21:13:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE799;
        Tue, 28 Mar 2023 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680052424; x=1711588424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9CP++/71DRMk8C1apTi4ZOxWR6TxSc7h+MRJrudzT7g=;
  b=RTUloI/RVkpdS654QPbTjOjsQ5gWvWBwjt+QFhnJclLrtOOOF1gKRh9i
   0lJZI40KI4oXvOTa9CnouKF0vgcOtz3KjtdCc3qqdKzq+MjjzV7K9Ylip
   pmdeBBa4sWoQWHuWbSTq1wz9ZsNMi6Q6ICZ1QeaMLPqXGjT5Pmv6X7viE
   cNQPR7BsYMUETI0X3y5cwZ0JPG43QByfxymvMplMNba85UaWXsESJjpdz
   7xT52oii+4cGYyGKGZ08+Y+pa5vnc3QGqhyaQAMym+vupidmc54I39QNT
   hoXRZoRkMf4aEmajsv5Bj7f0HMF1siTOxSehr1QpLtNIdTwsWAvCERRsL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321140766"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="321140766"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 18:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714435057"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="714435057"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 18:13:43 -0700
Date:   Tue, 28 Mar 2023 18:13:42 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 21/21] cxl/mem: Add debugfs output for QTG related data
Message-ID: <ZCOQxrpyXNABVbsK@aschofie-mobl2>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995357195.2857312.5279274659737251140.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167995357195.2857312.5279274659737251140.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 27, 2023 at 02:46:11PM -0700, Dave Jiang wrote:
> Add debugfs output to /sys/kernel/debug/cxl/memX/qtgmap
> The debugfs attribute will dump out all the DSMAS ranges and the associated
> QTG ID exported by the CXL device CDAT.

Do you want to document these?

The poison inject & clear inflight patchset documents in: 
Documentation/ABI/testing/debugfs-cxl

Alison

> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/mem.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 39c4b54f0715..bf2cb5a54a7f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,6 +45,21 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static int cxl_mem_qtg_show(struct seq_file *file, void *data)
> +{
> +	struct device *dev = file->private;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct qos_prop_entry *qos;
> +
> +	list_for_each_entry(qos, &cxlmd->qos_list, list) {
> +		seq_printf(file, "%08llx-%08llx : QTG ID %u\n",
> +			   qos->dpa_range.start, qos->dpa_range.end,
> +			   qos->qtg_id);
> +	}
> +
> +	return 0;
> +}
> +
>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
> @@ -117,6 +132,7 @@ static int cxl_mem_probe(struct device *dev)
>  
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
> +	debugfs_create_devm_seqfile(dev, "qtgmap", dentry, cxl_mem_qtg_show);
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
>  		return rc;
> 
> 
