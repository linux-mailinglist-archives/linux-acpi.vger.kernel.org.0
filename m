Return-Path: <linux-acpi+bounces-12195-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CAA5F92E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2662E17C393
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070C268C75;
	Thu, 13 Mar 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SmhlXohl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E02268C5B
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878164; cv=none; b=AxwYdp034Y2ddS2FFWipZJ53PubLjuZxxbyvLRVv+th0xUQ/js8jR5fkswKVxJNRGY3p3uAIl/aKURIvCMK2AtWmtqK8NC1zk5MohAiGViAAfXuZgzVfkw2Uf/YHjlRMYTjVOTV//kysH7RybyBiA5ej/7kgTFsmPjHI7MEI5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878164; c=relaxed/simple;
	bh=7zDs/4jK42T9rjEWm6oQy/xsWRIMK8LilWON+YAA9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRtnAGIhToDsA9AHRkvm9QmzBWoayWMxNAzncXub7m0bBmFbGD8V/zXWnK5cBjYjXt+b5I74b/m8/rhmGJ2VNfp1XpMEs3jkD2fMciq44JMf7HJ1za/nDBM9kQPxe3FokFxIxRGpWp2/20AysRK9j87dbYP2h+8+Ouapverhx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SmhlXohl; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476964b2c1dso17573421cf.3
        for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741878162; x=1742482962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHY1pG2tvmLOjvUIEAkagny8teglkhED6Z4pC45W9lk=;
        b=SmhlXohlhOkw1inTkuCmudxJb2FtoXioVgM0AuPDIpjTaw4nhQDVMH33mTYf0ayYh3
         NlVUxUQpMSsWyvFZ4d6wJwbdCxwDNqNuoIXnLomTJgKbBJsxXtDDtwqZlyxtUYtZYp7T
         XUDnY2u2/GQdNS4oVr2MB5MGrsbEwlmBW7yiVBqcu7O1dEhmzbTio+MZD7FBpd+dbNN9
         GW+Tgn+xricC2tjHWeXkWOvChI6dSx7hera8rrWEkFlXxZYh9mgK29Ue/hHDNaNBzZOt
         d4SCQKtNU82r0c0NXdkmMNJFuIokn2w4a+8KaJc+WUSbPtqMP729pE4a0arqDEF4glJu
         ubmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878162; x=1742482962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHY1pG2tvmLOjvUIEAkagny8teglkhED6Z4pC45W9lk=;
        b=cpokSGBrISbIyOnEO9Z3AE4/xAtRKagHpfSqZ+FD5AwjtEAnKtCyR7k5fceYzhSQ82
         G019VRrk0R+es17iCPZu0jYnJC27vn58nLLPxTYkN1Nzy59/rcL5uIRrv3YhbPzZcIiI
         NiQicYpkZXcBBDDIV5unYXCBb7xg3ckazCNscIikmyn+omQBin+0+oXoskgB0S0elchz
         4zmgem1/88HZQD7prV8VRFDwiZzK8c0XGiPWUDvGBNAEtoa9bziG+Jp26c3/ZnZFAwLY
         tR6uGxbW9WXTbl4xDf4SPGuLW3iRd/1gGfj3gFbbYlQaw4+yPVr9OXsgxYEPowiZTFVo
         3rRg==
X-Forwarded-Encrypted: i=1; AJvYcCULCw+NNysqnaq0v1dEkQViGXnEIpkkbbDzLpQPc2TAFB3r4BRu8IzWbWsP98S4trezlTgFTeI7k7QZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7qXRrLbcEMPhiW7HD9dnZ2wpk4FWiBrdkIhKmK5Z7eTp+qSj
	ZTD2ucg6pq0h5UTMYV+hff28hHS1jV6ksh5kIK1IHKE5wfkrttOVfBmKOT4b+lQ=
X-Gm-Gg: ASbGnctH4njHrPjsRlG21ZzMdsrUv5PvqQLya3uB/OR1IaKF7d/htTUDBlhJxNBM5aH
	Ty+7Vhmshj7tFK/NvoTqZ5SEhCHxjaD5JZfQOUjlHXzgPZaFCJ32/GL7okfU7qJMU82X0eZUkQG
	Ko6V96LkXv1ZWiyMv8i4CqileRyFt97fGKWfpVXL7OZlAlhUdh346p0IujCxF7maqM4c1ZHMczB
	tehT05wObDb+4mfhJyuqLsbwXcPCxqPq0uDxIsMN2wKNWIt7dyhbkLT7SC/OyWnxPM0yJt0K8zP
	RRgWAucUfu28AoOJ7f5r1halRVCzNqNIiVOn7szbQlm173nm0KyfM1S1yUMbSNZxyW7YFZJw2zg
	nXk4RVpwGxN7aGXI9iBhDkmfevEIZetUufcc0jw==
X-Google-Smtp-Source: AGHT+IFAMWILyZ8bMRGv7bdKKe5rM96j+5H6aHjq4gkCifNGEy5AffkMBaHGkUHELx5174kUe35U8A==
X-Received: by 2002:a05:6214:518f:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6eae78613admr673006d6.0.1741878161817;
        Thu, 13 Mar 2025 08:02:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24d025sm10481686d6.51.2025.03.13.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:02:41 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:02:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rafael@kernel.org, lenb@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, rrichter@amd.com,
	bfaccini@nvidia.com, rppt@kernel.org, haibo1.xu@intel.com,
	chenbaozi@phytium.com.cn, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>

On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> +	if (srat_disabled()) {
> +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> +		return -EINVAL;
> +	}
> +

I thought the srat was optional regardless of the presence of a CFMWS.
Is this not the case?

~Gregory

