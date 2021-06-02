Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B883982E8
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFBH3y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 03:29:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:18416 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhFBH3y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Jun 2021 03:29:54 -0400
IronPort-SDR: Rg24ilX1x/rWh+RQDZytjVh77cLG9fpOymsSi1HxeLc1WOOfQodKQ+aCXgODIvE5PbfCj4GNTp
 QSm4gL0UAFhA==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="191076166"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="191076166"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 00:28:06 -0700
IronPort-SDR: /jGuQacTW6w0bEroq9Ox6VWPEpRMzvyVO3WFegBnstguy2SurVW0+TuaJu/vKxaFlSmf+lgHBx
 Yt2VarDsO80g==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="445637798"
Received: from linyu-mobl.ccr.corp.intel.com ([10.249.172.12])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 00:28:05 -0700
Message-ID: <ede3060df241fa00e0ea994006af206e8bc8e6ec.camel@intel.com>
Subject: Re: [PATCH] ACPI: tables: fixes the missed acpi_put_table() in
 acpi_init_fpdt()
From:   Zhang Rui <rui.zhang@intel.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Jun 2021 15:28:02 +0800
In-Reply-To: <20210602011723.23666-1-jingxiangfeng@huawei.com>
References: <20210602011723.23666-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Xiangfeng,

thanks for the patch.

On Wed, 2021-06-02 at 09:17 +0800, Jing Xiangfeng wrote:
> acpi_init_fpdt() misses to call acpi_put_table() in an error path.
> Add
> the missed function call to fix it.
> 
> Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT
> table")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
>  drivers/acpi/acpi_fpdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index a89a806a7a2a..4ee2ad234e3d 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -240,8 +240,10 @@ static int __init acpi_init_fpdt(void)
>  		return 0;
>  
>  	fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
> -	if (!fpdt_kobj)
> +	if (!fpdt_kobj) {
> +		acpi_put_table(header);
>  		return -ENOMEM;
> +	}
>  
>  	while (offset < header->length) {
>  		subtable = (void *)header + offset;

