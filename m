Return-Path: <linux-acpi+bounces-14461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BC3ADFD32
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 07:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D500B3A7DFD
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 05:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6724397A;
	Thu, 19 Jun 2025 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp3C77lr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AE242D69
	for <linux-acpi@vger.kernel.org>; Thu, 19 Jun 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312016; cv=none; b=cx6DUF4vpOJUYIDVXPVl9/Uayv+kpMSD5Lu4HELpmc79ugBo9QoNRxSjUPvTqjuktbKbzpfJbqWp+uG3eS0eBNsSRSZZVySjpO/oOYbEGhZcxx/uiwl2loh42mKM3/qlanmDs053TRiIYVWgag0aBK/SjlRGnYzC8cuhQjKHZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312016; c=relaxed/simple;
	bh=Bn70nPJu3HUp/M+KYcLviCtpjLHOrJf1pcJLvrjQ/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khM5Cv7sZOBtgYeV6TFJgGsTr5ECCr0f8VEQYZICCe4F2XtkxlbDW/Outgy88dPbjeXAHZb3c46pxlfcwA24UU+Jr88cnXnZ9oDwzvVReoZGuQ7ymFkdG2VEIv0LRnezKhPDoieXKJt7V2epgEnA0r/COeVSJqzK1uAQ8pD/ctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dp3C77lr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso305611b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312013; x=1750916813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1Xvm2/dcHJBRt7NYvlZ+VTR+ErXbR50l14mI16oEhY=;
        b=Dp3C77lrzqGDO6ludV5D8bL0F7AwlrR8crpDyn/Om1g4MUBSXb13znlJ0KhQRNxPO1
         iHZvLYLhLoCFNdfPbHP7V913x1P470fwT5vyPQU48GeTAUoGkB+iTGucUdcJKqT5xawq
         NW316AlnSbmqgDW763um18OX0EuUelEzae+qHfrY6RFeyfjbZkZ5BoAD4YSemNfuudb+
         owq38O0EgaYHC1bsWj3w+hIwWAR/2vWdmg9LokuwCPgIn9X+SN1fpzBOvFdYlaT7ovIe
         GDRYIAInDBCxR2jqbrBS84ZGk4DhPb6j81zoQFeL59YtCj135C4gO5D9UbBbpTvGdvvO
         /hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312013; x=1750916813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1Xvm2/dcHJBRt7NYvlZ+VTR+ErXbR50l14mI16oEhY=;
        b=iunVJviBKKyr5SpREEQYuQx1Kz7RCrTd+FBLcvDAHDCnHXWFWGMiopLhNUselHlcZG
         7iG4OpA0qgYlFZNDDuzuQdM7Q061IkXfRqBpbYQyIejE4Z1GmiclJcpR3WrHEpeINcSQ
         JThCPbctcdntpcpDk5HMVQnkOPqwqjHpxiX+g8LKG+4uEBqhm7xUrFKxpFKwWv3Ouc/H
         9OahMiQZFylMNafVn+N0KMX16s2srW0V+NVHaoEaq4xvtXtB9inrHVkC/7rQPNf+QD5p
         ewu5S1mkZE1sIfdQGbvYYaBsU4VgE1kjMrUJoMQvUYGMvQekLBoWwH8Uh15iZyNtxxPb
         sjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBdv6oCXUVW7vlEx2O/aX9PbZ/966PjT5DU3eyRLM2NNe8uf8SXtwd3aR1T5a6nt/oWzKqXOSNP7+d@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8HbfNqvotSBvhLctUie0J55MHvbA0hGspr81O77y2ILhzIzm
	tQgluRZbm7s1Qzo+c1KY/z+I31INiKOVc4l6TAkA9yEqXPThD+B7BktUH9jy1grOCqA=
X-Gm-Gg: ASbGncvzR0ri0x+/f1Z8Kw2U/MhgjfPocEwtozEsIPXjOOTtZRzOpdbRzQX1p9gq41o
	b3NMUEnSJMJffHPHjn2xs8Q2Ndcy0rznP7QDYrLr8/5KR6w93NrkrkjBIhU1TaEU9pCfTiVgPoz
	+f1ssCpaBzHDQRJnMEF5MHgxN8rTQQeYpgXUV9WP29/V60cNfm4tY5GGV63CiS2VDSpVL5MQZjx
	MTDes01dfzLTZ8iN/QJwl74K9yQJOwkMyIahdAVP7+ws4L/UpZ6HCvA+Ty+Ej6lQXDtIlPC9P4x
	DFcIOz5dsmDKEKXRGc4OfoMcy+hrzmX7Il4bAZaon52tS3Kf/2xey/ziFaspE/U=
X-Google-Smtp-Source: AGHT+IGx25UdEAzlmqfQKTPAu3rI0FpfbMxJfPd/PkIc3VTClQaEGNZW5YGAM1Nh7zWb+auXSU7+sw==
X-Received: by 2002:a05:6a00:10d2:b0:748:fd94:e62a with SMTP id d2e1a72fcca58-748fd94edb7mr1182029b3a.1.1750312013191;
        Wed, 18 Jun 2025 22:46:53 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748e86b5527sm2820713b3a.86.2025.06.18.22.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:46:52 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:16:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com,
	cenxinghai@h-partners.com, yubowen8@huawei.com
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
Message-ID: <20250619054650.pl5ase2l5juu5pm2@vireshk-i7>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526113057.3086513-1-zhenglifeng1@huawei.com>

On 26-05-25, 19:30, Lifeng Zheng wrote:
> This patch series makes some minor optimizations for cppc_cpufreq.c to
> makes codes cleaner.
> 
> Lifeng Zheng (3):
>   cpufreq: CPPC: Remove cpu_data_list
>   cpufreq: CPPC: Return void in populate_efficiency_class()
>   cpufreq: CPPC: Remove forward declaration of
>     cppc_cpufreq_register_em()
> 
>  drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
>  include/acpi/cppc_acpi.h       |  1 -
>  2 files changed, 15 insertions(+), 45 deletions(-)

Applied. Thanks.

-- 
viresh

