Return-Path: <linux-acpi+bounces-21323-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBEpLPPnp2mDlgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21323-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 09:06:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E331FC28D
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6969C3147CFE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84D384233;
	Wed,  4 Mar 2026 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="PXeFPg/c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA88377002
	for <linux-acpi@vger.kernel.org>; Wed,  4 Mar 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610934; cv=none; b=ITDzQ/omlT50PRG5FxeqaKG+IFj/nFI9SU5v9SlcK1T98yl7hcSmRx4mSA1kQLKBl7d9/u5Ub4b53sD3ol94RJlg+fLGc09GF8z3G6rk9+0jB6f8CEPc9F7WJ7m0Ehqm8jdgKCXqSCoGRFZT7njdSkFI1IJ1k6cMbgjKzged8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610934; c=relaxed/simple;
	bh=spW69giXt3iCN4mkbiiykMqhdbJz858ckzNh6YJB1eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLIore/i7GGB1+wfIBrcD4eqTEbWeVO1XSt6m8wzq3PWy+PDixVygZ7gD8O3NkPSfbY4vngFyz21i9YZxT0DEkAdLGTI0+CYdn9yBNqK9cJVHGp1jTT/8dgpai2D+5on9RMV2+4a7n+eUaIUZhW7AmFrUpQnjbi02mIPBdZsHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=PXeFPg/c; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35691a231a7so4036163a91.3
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2026 23:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772610930; x=1773215730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d26wglEJJkjfXy3+5eMzSRmt/fkICHWyBpSofh5tqJc=;
        b=PXeFPg/cO2a7GlRjcQnO8q/cWrYEw+hoRr4fVpstdRO1e0yqJGeVQUBngcwuFbFaX4
         UgKNWLYF6G8dcQ7iyy+cNAvTTjvUyRNNysK9UPIirTnOujTZdEdh6D++GMnQ7FJPnQSn
         pWrc93Nq1M+DWRpcFEHxaX2Uql7DRlImsrXl4COYyL0kviFp9N1/qppM41b77CURptKp
         8WkYPqWpSby8r/QyZO8HEYADdKlpNUvrwrgRktSxdSioNxHq8p9D72S6N6WykdwO5VHY
         NACsaCY9DTRLDPn3APLn6qNxNx0d+/i1WBuYmdYQoTOdErcIpukiTCss5jOkGAwTfkXd
         TOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610930; x=1773215730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d26wglEJJkjfXy3+5eMzSRmt/fkICHWyBpSofh5tqJc=;
        b=lohgScZupTw8Jim2AlH+3ibvei0f1oBayLreMZ2aw/Q6ja2xxz9i6F8sDClgsM6Bur
         YMItZCxYYVXu29fxzmoZyz1jTLlANmgF2WZfTlxvZeH/odLKWzZMI2Qiy/cEVG9OkVfO
         hdkMZkzYpa38lVSyolVX7ujbXu2DLrUxLGU6K3h3rZHFrxDzZaCMpTXBtyzC885MzIfO
         3udHOrJD8TSKxJztM58B9zj9Q00c8seV0wbKlR6aeaPQtBlXJXgVzp9/pbNWopLPEmJM
         PLunxuviZiIjucwhJZQMVtIND9mQK+iYfk/hMi5T5RI/+S3ULnj8kJE+kdh3O3hNBjB9
         H2yw==
X-Forwarded-Encrypted: i=1; AJvYcCW2cDi/3id4r1ZNRLT3L6ayY4lmbPQKNpK1qK+0w6gP3jHVr75ooGzj12NbwRyWrFGg/J3PDc2ZSymX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu38TU1igSEgUdWC3WZn0/FT9NsDRy+jWdg3numEm+zjx7UBYw
	0A5K2rzbU3Wj8KV9JmDgKPkNZHpPQAjMsh1oSG68Z1h8J11ZBICF4AJtv4SUG+G7VmQ=
X-Gm-Gg: ATEYQzwsROCuIs1f77F06PXH4eOMJ/WQZfxleqKMKiov7uv0+weRz8CJsiPxnfm1zag
	zIm6ACFdfGqOgKvdJUnGzMTzzv+NKM/MKZf0ckChzaqZ1b2XpfCBY9hP7t8VCLkV+7QIyXfv+R9
	fwXqW51vmrALTm6VEFmzYflpGQ0pXCSbAHKEuR97ocJftFdBtS5BOLt0JIcgX4QV1JStnf0uhIK
	8EC4ihD2q08jDwgJfcRWqSLjJ6FApmD3hgbSyOtBuUPcvwJK/b50mHHO7PUyznCCB/Wfv8QffNT
	UGaB2iva6RrYYk+2n9wHDZ1PRZBvqhpAuC8gbmEq8tS2Y6uiPk3ZagELNu305BacWo/+M0zDiTw
	Xo+lxOrsuwrCTsU0H2f1AWjDg/Dm+mLubAATYeF/SkrAZhYNAnx5mkBGWg0wj+GV30OOv4k2J4y
	UY6g97i29FdY7gZJSLb2QSTOGTUiqLyGkb+gYN
X-Received: by 2002:a17:90b:2884:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-359a69adf47mr1114314a91.5.1772610930325;
        Tue, 03 Mar 2026 23:55:30 -0800 (PST)
Received: from [10.54.26.107] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8e768efsm364872a91.0.2026.03.03.23.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:55:29 -0800 (PST)
Message-ID: <751572d2-2665-4a67-8098-2f3a69668e0f@shopee.com>
Date: Wed, 4 Mar 2026 15:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
To: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304064609.75585-1-haifeng.xu@shopee.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20260304064609.75585-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 34E331FC28D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shopee.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21323-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haifeng.xu@shopee.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,shopee.com:dkim,shopee.com:email,shopee.com:mid]
X-Rspamd-Action: no action



On 2026/3/4 14:46, Haifeng Xu wrote:
> For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
> the possible node is 20 (0-19). However, only two numa nodes (0-1)
> have memory and the rest (2-19) nodes detected by CEDT is memoryless.
> 
> The problems is that when creating many pods, the shrinker map size
> need to be expanded for all memory cgroups in expand_shrinker_info().
> If the number of possibles nodes is too large, the holding time of
> shrinker lock grows significantly.
> 
> In this case, there is no CXL memory inserted in the machine, those
> memoryless nodes are useless for us, so there is no need set them to
> 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
> time is reduced from over 10 minutes to approximately 150 seconds in
> our intertel test.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  drivers/acpi/numa/srat.c | 29 ++++++++++++++++++++++-------
>  include/acpi/acpi_numa.h |  6 ++++++
>  2 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index aa87ee1583a4..8716d70043fe 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -31,6 +31,7 @@ static int node_to_pxm_map[MAX_NUMNODES]
>  
>  unsigned char acpi_srat_revision __initdata;
>  static int acpi_numa __initdata;
> +static int cfmws_numa __initdata;
>  
>  static int last_real_pxm;
>  
> @@ -39,6 +40,12 @@ void __init disable_srat(void)
>  	acpi_numa = -1;
>  }
>  
> +void __init disable_cfmws(void)
> +{
> +	cfmws_numa = -1;
> +}
> +
> +
>  int pxm_to_node(int pxm)
>  {
>  	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
> @@ -313,6 +320,12 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> +int __init cfmws_disabled(void)
> +{
> +	return cfmws_numa < 0;
> +}
> +
> +
>  __weak int __init numa_fill_memblks(u64 start, u64 end)
>  {
>  	return NUMA_NO_MEMBLK;
> @@ -648,14 +661,16 @@ int __init acpi_numa_init(void)
>  	 */
>  
>  	/* fake_pxm is the next unused PXM value after SRAT parsing */
> -	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
> -		if (node_to_pxm_map[i] > fake_pxm)
> -			fake_pxm = node_to_pxm_map[i];
> +	if (!cfmws_disabled()) {
> +		for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
> +			if (node_to_pxm_map[i] > fake_pxm)
> +				fake_pxm = node_to_pxm_map[i];
> +		}
> +		last_real_pxm = fake_pxm;
> +		fake_pxm++;
> +		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> +				      &fake_pxm);
>  	}
> -	last_real_pxm = fake_pxm;
> -	fake_pxm++;
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> -			      &fake_pxm);
>  
>  	if (cnt < 0)
>  		return cnt;
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index 99b960bd473c..2435f60e56ce 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -21,6 +21,7 @@ extern int fix_pxm_node_maps(int max_nid);
>  
>  extern void bad_srat(void);
>  extern int srat_disabled(void);
> +extern void disable_cfmws(void);
>  
>  #else				/* CONFIG_ACPI_NUMA */
>  static inline int fix_pxm_node_maps(int max_nid)
> @@ -30,6 +31,11 @@ static inline int fix_pxm_node_maps(int max_nid)
>  static inline void disable_srat(void)
>  {
>  }
> +
> +static inline void disable_cfmws(void)
> +{
> +}
> +
>  static inline int pxm_to_node(int pxm)
>  {
>  	return 0;

Sorry, This patch is deprecated. I'll send a new one.

