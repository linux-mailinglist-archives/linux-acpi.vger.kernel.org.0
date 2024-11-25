Return-Path: <linux-acpi+bounces-9774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B29D87F9
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2024 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79918291014
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4420F1B21AE;
	Mon, 25 Nov 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDDqE3Y8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4E1B0F00;
	Mon, 25 Nov 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544897; cv=none; b=AqDLf/74ns2+U8xJ05dIkNCisrkFbphVLeMYJe41AlFfsf5W9sadplUY3Xh1XsW/d3BrKr1nMJWyfV231ZF5W5yMWH9NR4/X/uA5qDFResX0gAiGFhRGqIcd8ZkMA+GrGnSO4slKMxZcZ8bhiNxBXl1if7qD/Hk/1/VTv1ZOYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544897; c=relaxed/simple;
	bh=Qf3XtGHQ0/jTjJ43p9AVdX2cxiPbXJVauEKR2OPlEZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4TIVv5KcLBrsXoCiFtiiGl6nlrx5QMdw+Ks1GmYl556qwKSw89KN6aCYUNrblGUjWQ1PIz4neHZx8oRqTsiBngY5xRGzziImzl4nXJD86J4zYmumKYHN2DrEngrrU76bZW+TY8XkTpv+9k5n+FvhGazKFYR8M0agyfK/1WXlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDDqE3Y8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ed91d2a245so1978313a91.3;
        Mon, 25 Nov 2024 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732544895; x=1733149695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSVP8dLhnfmOPUZLQquRunhFtYrfA4jCVwxh5IIYTUM=;
        b=lDDqE3Y8PzgN4FWQ2A/wgsJa7XB9+28Qy1dlj+DasXs5BAhTA4KaTlmzA+r2kj0tqr
         iSK3YR2Fr4uLgi5GD/sfukk+PgUxuZte1W6UnMnVGlVJa1mWLrroemOwBJBeWcfNGoc/
         iCPcI2mREdyCWzvl8pDQkyczwD6lh4IGSq1GTaasxa7QU46x6459nj12UEXaIUfuvVht
         XXWkX+YAmz/zq3VlLJP0vuixwz3P1MoL+znfi0ALgr0otdZrC0GmgF7NvGyKob2aT2R4
         OZS7UF170Ot1i28X6w4kpBDiQ7mAnAtPzA6CpoJiOr1Jo2ipa7AB5DtC2rrpEZ96MwLn
         WzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732544895; x=1733149695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSVP8dLhnfmOPUZLQquRunhFtYrfA4jCVwxh5IIYTUM=;
        b=NGOOZCEpkmi+wk4vEtCfQ/G9fV2YEWOliY2l3ZMsU2PChZvuKd7LBAG9NeD48rjd3H
         1D7H5eqJ2QuYaC84y6thWwZSGOhfTK3U2JrMvSIuk4IyEmZCGyJr/QsCiVWScTODr2Mh
         q78/vKBKD54RnwsgtfCqJ7yBsgZTreqFsQtFrZZATdIn9f26xMX3/MUYi7jqc/lglXBI
         +vBoON+wm6xguoJlJR4q7oHFxrLngUdHxg8bh0FUYowBIQplYzVc888ufYT4mnOaS9Kc
         gvtVuSf3z8xP0vlXA5WOoIJ/aNuG6ZBGF6is1nGuMVArQwNqoyBhk4TYoPKDFAeUOIlW
         jjBw==
X-Forwarded-Encrypted: i=1; AJvYcCUEc1mF6M9je+j/t54Pp7NQr5tJWroe7V1unWeDsjKu4eqeF4E4qmTNDiLzWUl8shWKa+eFHK/0hBFRKrLa@vger.kernel.org, AJvYcCXdXfFxHCgJbrLMHkCLLIv3yF11Vt+hFaEBCCb5mvcuEerVYZ9/TGEwrlPHbmEFQ9Dmo3HDPt8G38Ev@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2pMF9uGhjYCu3YPl+3WYS0B1SDXQ4CmDAq9LbNL6eLYjllJV
	Ngmhm6NzCJAwNHk7U/dFK0yUSMBayvXGYzeQJC6XGOJhBH/M86PX
X-Gm-Gg: ASbGncsjXf2LOUFdb/5r0T6G+saXiBBLBBT67D1n+trDxTY33m6oUQhO75HXX5SgWma
	EioJ8LmI7xDt+svZbKsPNmkrDNFVydndWAgWVUEX+zao3rgu1i4/AWt7ctfdTuJd9F1cb7tXNdR
	IMBvZJyUPC7SUJGRqFDvU6ymdZ5TDRY/Q7qhGCyGBoM8h0QTbacu/cSNWehNKVtpL5Vd8eJ8tYf
	wwK+lQUhdCrKlPHZOQZ+XXyc3FzLt0+8L1Yue9vvHHh9YiFZRV2V27B1ebu3ESH
X-Google-Smtp-Source: AGHT+IGHciRYAqsEoY+AXmAdv95wOzs8u9pLXgMOFRX3xePzc95shLnnHTASUBw9vTsO9x2paV/+3w==
X-Received: by 2002:a17:90b:4a92:b0:2ea:5c01:c1a4 with SMTP id 98e67ed59e1d1-2eb0e427a67mr16907227a91.20.1732544894866;
        Mon, 25 Nov 2024 06:28:14 -0800 (PST)
Received: from [192.168.0.203] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb14397a6fsm6492612a91.51.2024.11.25.06.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:28:14 -0800 (PST)
Message-ID: <1813d5d3-6413-4a44-b3dd-a1be4762f839@gmail.com>
Date: Mon, 25 Nov 2024 19:58:06 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 rafael@kernel.org, lenb@kernel.org, nvdimm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241118162609.29063-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <20241118162609.29063-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 21:56, Suraj Sonawane wrote:
> Fix an issue detected by syzbot with KASAN:
> 
> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
> core.c:416 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
> drivers/acpi/nfit/core.c:459
> 
> The issue occurs in cmd_to_func when the call_pkg->nd_reserved2
> array is accessed without verifying that call_pkg points to a buffer
> that is appropriately sized as a struct nd_cmd_pkg. This can lead
> to out-of-bounds access and undefined behavior if the buffer does not
> have sufficient space.
> 
> To address this, a check was added in acpi_nfit_ctl() to ensure that
> buf is not NULL and that buf_len is less than sizeof(*call_pkg)
> before accessing it. This ensures safe access to the members of
> call_pkg, including the nd_reserved2 array.
> 
> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
> V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/
> V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
> potential uninitialized variable usage if condition is true.
> V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
> and updated the Fixes tag to reference the correct commit.
> V4: Removed the explicit cast to maintain the original code style.
> V5: Re-Initialized `out_obj` to NULL. To prevent
> potential uninitialized variable usage if condition is true.
> V6: Remove the goto out condition from the error handling and directly
> returned -EINVAL in the check for buf and buf_len
> 
>   drivers/acpi/nfit/core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5429ec9ef..a5d47819b 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -454,8 +454,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>   	if (cmd_rc)
>   		*cmd_rc = -EINVAL;
>   
> -	if (cmd == ND_CMD_CALL)
> +	if (cmd == ND_CMD_CALL) {
> +		if (!buf || buf_len < sizeof(*call_pkg))
> +			return -EINVAL;
> +
>   		call_pkg = buf;
> +	}
> +
>   	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>   	if (func < 0)
>   		return func;

Hello!

I wanted to follow up on the patch I submitted. I have incorporated all 
the suggested changes up to v6. I was wondering if you had a chance to 
review it and if there are any comments or feedback.

Here are the links to the discussion for all versions: 
https://lore.kernel.org/lkml/?q=acpi%3A+nfit%3A+vmalloc-out-of-bounds+Read+in+acpi_nfit_ctl

Thank you for your time and consideration. I look forward to your response.

Best regards,
Suraj Sonawane

