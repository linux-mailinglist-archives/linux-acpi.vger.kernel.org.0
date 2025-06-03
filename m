Return-Path: <linux-acpi+bounces-14084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF9ACC756
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EC03A29F5
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C722FF2D;
	Tue,  3 Jun 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8Rtsj3d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67DE555;
	Tue,  3 Jun 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956002; cv=none; b=UC8hX7jiBNdsYzvetctHtBMEvSocHPY3o3Y2aCZcqP7N6kKfClj20iVd3qqpS7aS83qsQVC32F9I9jyWMX5quKJH/0pBqGR4RdFPfACmAq674zGVPm3rm3gOylCEOI0cGsoDxX4XXVB7fMm3O8r3m/LHx/hqew26pE4elu1oycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956002; c=relaxed/simple;
	bh=BCr7GIiuUO2pKsPic3aDxYvqICfx1M5/86X3EyLcGx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M28dDHV4pgeVScK4eMYb/gxwPrVOeSx2RqGSmll9bMnVjJ6nVk3E6gUXbcUKmtGbJkLab8DP9FUFvEhmSi22kPWj3yDsVQAbqot4lZFxrcy5E+Wjgr5Bjloz2T7/3CAifH8nJvr7+P38b9WwurCmTisq0JCdxrws7l14YWCPZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8Rtsj3d; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2939864b3a.2;
        Tue, 03 Jun 2025 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748956000; x=1749560800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/f20/458IAFhCzkUWgHcem7N3YGetstsrc6uh9Gjc8=;
        b=H8Rtsj3dy/LGHBYdM2jsoVXuksNlfrCO9Vc8yVqxHfpGmYwG8jp1DYQgnxuX9wVC/m
         jC0i1mrUBrO/rMHBGocxJKB3jQpT1t6lP3J+IN0TT5nqfn0kl+caZKvtahCLpVA+lEIV
         sxeRHxn9WIN6xskrzY5W/xxqOlkeNHlegUITwvIaq/nrfMXrujfP6yEEVPAEzWB5MnAP
         8ZCZpVsNQMtmE4P9IPvSpvgli6QC4o+yvtcIzPRotWDS9MqxKBKMn1cyoitMoJo4soOy
         BsMLmTIq9nVwwu1jP37ZoSakyVfKnkTwsI0uk5nDHsfF7pkiZIJ/bgn9aTU2+/RdQFEe
         AKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956000; x=1749560800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/f20/458IAFhCzkUWgHcem7N3YGetstsrc6uh9Gjc8=;
        b=MXs9lIyCSXN2vbUfWmAO+jRelujmqPH3+WarOzqRPok3QTnehHx9T2xJ7YrCA75RiX
         Zr+jdbi+/Ewyyvw1VCXarhjgEVSr2IgwaeqXbQHS/MEbCrIeqpR0VuWPQIKxCLQbLxbT
         pGsnHbZ5/I9mYdDS7IxXUJMer9omneZEfgTLIz3XrMih6D6z9wO/ompt95Rz5RjriXK3
         AM1zmDRO8LAtJAZSe8np6uaZCu8/GyRhL9sfoAEAV7LdOsF1xiD+0eYuXh91xWt52YNe
         B4T10xIeNFAeTG7sfhn0KnNUHKtoEWtk8MZEQP9ZB14I1ie2/bPYyBaXLKsggcLITE5+
         61cw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ages6nxzDTdR+eTtwvbGopLo2lFRJ09DrMW2ki2/AQMgdUssR5jXNzVEeOV3+hecAqJPbKrl44t4@vger.kernel.org, AJvYcCUWif/snteA45bZtqO13N0q9SJujj7XwxJRRGICCpnpuFQI54aup9WiZcUsC2JrXL2KTiQ5MjOiUv2DcK2a@vger.kernel.org, AJvYcCXGv82edvc3HAZVqzcDGAovELITVcIuLX63VOvpjibr5SksfZ5zlJaUfqS0LjbgXJMhphGT1FNAhsrY@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKV55WOFQk7Ad+HIJB3ZHlB36qvbv60mJL9vDfvl/va+4Tf8f
	EuQ9nvX8tSk5PSbRd1u3O1LJsYhMWIIe0RwCDzX/BfHiPOVgH17UtlVV
X-Gm-Gg: ASbGnctBbb+t1xBAzcVH7G8/KaVqvazDDzMaTCaLx5ckbPwgMAm2rYN8aRPnCgzxkCb
	BJxes6glPg9gyiW17zvgXwn3JE2OYiAlqRJkH7kE3qDa5D5hmZvE3WMho6VbBRmJ3JO60sWWqZR
	xje0muCThuSYJbqPZ0DTq1Gj8YC7Wh0UTGQ7+yRe6ITdadvI6VMYXp4FqOIQTuWjNipUz5sNxJE
	8WqscShiocWyUvdy6+HVEKeh+Nsv9lVLIRM06hwRyWUA7cjBY18SKaYsNqpFcZvYlA+hrHr8Oo/
	ReBBHGGHOZ6CZcSl518MzwfnuBuECV+cl7+Lap9J50K8wR40k4LrgPF99DTqckGh
X-Google-Smtp-Source: AGHT+IFS6CTlI8UpfHYxqjdx1tNG8cfSJRAGppMmlPcr/BiaoL+v48NartI8bBJjtEqQATncKxJnKQ==
X-Received: by 2002:a05:6a21:32a1:b0:1f5:9016:3594 with SMTP id adf61e73a8af0-21adff61278mr25343927637.18.1748955999729;
        Tue, 03 Jun 2025 06:06:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb6857sm6097535a12.73.2025.06.03.06.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:06:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 3 Jun 2025 06:06:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, rppt@kernel.org,
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org,
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	haibo1.xu@intel.com, david@redhat.com, chenhuacai@kernel.org,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	chenbaozi@phytium.com.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: introduce
 numa_add_reserved_memblk
Message-ID: <06a0abfd-5508-4fb5-8a96-a13cf3d8aca7@roeck-us.net>
References: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>

Hi,

On Thu, May 08, 2025 at 10:27:19AM +0800, Yuquan Wang wrote:
> acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> with the expectation that numa_cleanup_meminfo moves them to
> numa_reserved_meminfo. There is no need for that indirection when it is
> known in advance that these unpopulated ranges are meant for
> numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> 
> Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> ranges directly.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Just on case this has not been reported yet:

Building loongarch:defconfig ... failed
--------------
Error log:
drivers/acpi/numa/srat.c: In function 'acpi_parse_cfmws':
drivers/acpi/numa/srat.c:467:13: error: implicit declaration of function 'numa_add_reserved_memblk' 

Guenter

