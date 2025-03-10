Return-Path: <linux-acpi+bounces-12006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178BA59778
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49692188D7E4
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD2822B5AD;
	Mon, 10 Mar 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aCBNVXNP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0A22B8C7
	for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616536; cv=none; b=glFPAU7RN436Uuz1jtSnzE2QN8hxmqBvOqMmgtffgOXH12scugPXvDWwYWEvRdQTEfgRhL1wp7e4QGW0olqb9R82dE5o53lveWzCLjfFcIguYOel7aAWj8TkXeNzpRavvvpFimQv9xdxXr5Tmke+/tJdrc7QBrfIIMjEnW8b6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616536; c=relaxed/simple;
	bh=GopVi4CFli9+2u8VyRRCUiOOhbr6gjtfX/hbJvOfiDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoW/FfqfnjD8z/ehrH1Cdlx/wcci6+A3u7tUzWI7IISpUihEbeEeru2Ts+Xin9FbiCooe5Yh4nFyRCu8LYfntP8FWtAj3pLtKQ2FL6JFJGt0rVn/uaQORUEq4D3t8jdfmA84qmP0E+UAuJV1RLdfRuhSJGeCxNRbMQ2l45E8lxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aCBNVXNP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c559b3eb0bso31595285a.1
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2025 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741616534; x=1742221334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqAivX8fNZr1y5mCMqdp2/vAbFsiV7nutZcGvyFYNRs=;
        b=aCBNVXNPy5NXU+Y+aLYqID97r3sNYkcNqH/Vw+Jszu9g2ysAXpj4M9Q/51OLOTsBGO
         XnET9eGTcxgwt08T8TOqRfPyrRYDwovO4oungzj66WaIQNg1cbsgCaeg3OISR8lBrILE
         5CR0e/bn4HqPCBi21v+waF76cEDG6+dvoAu+wtuSKaz6vPRCLchuc4850PsEzTtUIx3D
         J38/ipz0fU0S4B0FvBNJM+zO2gvgpL62f1JsnMAwk5H2qtuSU6IaVNcxyEjwhCodQdRH
         gjjQ8puQsI83FBZa1z7A7N/VKwyk78jwyEuUrsMkvZoCy19sdEhjD21BptRogAg2X2yy
         SvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616534; x=1742221334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqAivX8fNZr1y5mCMqdp2/vAbFsiV7nutZcGvyFYNRs=;
        b=tuIXkgfBTYxVId0E/qFHo8nrjUnY15bP5ZOyBJAuh++uFUzi/g6J9JODJYRK8h5wBc
         MWxfwi/HeuULWDexQIB7AZRSTrkPxlDeXL+w0rE8QnJF6zzXCJH64dNx85+eHLvVl4q9
         Myk5CslQ5XdV5Jb891hyO40vfXfll733WYfG4N7h10Mteiqa0R7J6yhzLa0gizsU9laN
         FjFDBz1WyyQvzGde+uvlsVVri2P44AKbGk9K0ELhiqDHWYuTUTmDQ4ZG6aSz0NgH/M2e
         P9ZIKyrYmxM1KQJbKPKhaKSCHmuuQhSPh2JbHtK1wMPF0URFeDNw1enO+CQpToDJJoU/
         1VdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAPfbrxi4ugxH80efcPh/wXwDHAR1ll7qmPNhLVTEB8zwAc2jJoI2tsoPoicFeuynxqiEDf2puJ9ee@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNq5KQNLMKs++54mz+NapCr1M5lxXSVpBVNnv9V/VIjb27KY+
	Jjj3aUbeCsRoViOgQ7JgKOQe5Cg87MQ71lmrBRo2IjOS7KD6FiouFgBT1NCWdW0=
X-Gm-Gg: ASbGncv5DJpKtkZp/uTAA6CNVS3gaiAeHuMojhLHFjtKLJJTebciz/i/UvK5IqiVNU/
	USRsLCPLnILTdDC35LVHHobrYkr/+xaw1E78Z4CQcnNlt09a0sSeOuAAxBkIGXAEU5XZDmRu4TQ
	doTEXBxkvYV8Z5gJxNHUeXo3idT38Ttgovff1MP9cQYWRt1qF5LrRDzm/GGgOym5SeVJlzKQe7P
	P9D9r3Vt/9FM8+FM1pNl7jBpxVKox/qUS61ElXow7ehuchdA/qRoQMFCHO7ncwbKubL59cJglFO
	EuH+EqUuMyO5OYfm43REzQNMaYi1cgWilQ3VuxBDBE2keT9qRdH7apieDPMNlNyYo/wBAJrIzJa
	gXF54xeicd7i0P/Rz2cscugn4T+w=
X-Google-Smtp-Source: AGHT+IGWp5c3aEnPJVivT/AhAFPuiRfwxBggFm2GJnLG9GVp+RjnZOHURcFZvyyZYlV4KH2xR6gLmw==
X-Received: by 2002:a05:620a:4397:b0:7c5:54d8:3d43 with SMTP id af79cd13be357-7c554d83f59mr522944285a.58.1741616533797;
        Mon, 10 Mar 2025 07:22:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c555478e28sm173939785a.36.2025.03.10.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:22:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:22:11 -0400
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z871k085e-Th-jTz@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
 <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
 <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
 <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>
 <Z8syE7l5H35pk9T5@gourry-fedora-PF4VCD3F>
 <9caca3a8-280a-45bd-a081-cf4a28f05f21@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9caca3a8-280a-45bd-a081-cf4a28f05f21@sk.com>

On Mon, Mar 10, 2025 at 09:26:48PM +0900, Honggyu Kim wrote:
> Yeah, the proximity domain detects the node correctly as follows in dmesg.
> 
>  [  0.009915] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
>  [  0.009917] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
>  [  0.009919] ACPI: SRAT: Node 1 PXM 1 [mem 0x60f80000000-0x64f7fffffff]
>  [  0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 0x2080000000-0x807fffffff] hotplug
>  [  0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 0x64f80000000-0x6cf7fffffff] hotplug
> 
> It is printed even before CXL detection.
> 

I wrote a some documentation on some example configurations last friday

https://lore.kernel.org/linux-mm/Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F/T/#m2780e47df7f0962a79182502afc99843bb046205

This isn't exhaustive, but as I said with Rakie, I think your
configuration is probably ok - if slightly confusing.

What I'm going to guess is happening is you have 1 CFMWS per device that
do not have matching SRAT entries, and then the CFMWS covering these:

>  [  0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 0x2080000000-0x807fffffff] hotplug
>  [  0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 0x64f80000000-0x6cf7fffffff] hotplug

have interleave set up


