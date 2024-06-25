Return-Path: <linux-acpi+bounces-6601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090C915EDC
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 08:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7AF1F22FA6
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F30145FE6;
	Tue, 25 Jun 2024 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CN5gE+Eq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4B143889
	for <linux-acpi@vger.kernel.org>; Tue, 25 Jun 2024 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296659; cv=none; b=UjpObYnfrd57roU6bUCnUwNs2hojImUsiOvuT7Mvjvb/iSFN2gI6dTLaklgj7fSbzCSd8kamVLCb1wcJfWYr1ITX7uyMt99jpqBcyaEheF4DTiT6ldyqJ9vEjIRiJIOeqpDPy/ZgcFiD7bst3hvVYQa5pvSKx3ElyIerE0K+Rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296659; c=relaxed/simple;
	bh=fEXCEnroSXAYBbJBA50IuH7sIV8SQp85V0rc8smZn84=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Ujm9EhjU2MDYAtRKfBY9hJg4XLci4DoIeGzlYIoXRJOrZNqnYLKgHD5Ell5I5UfpGlEyDH0K9tSbG5bJ4VWfpCZs1y4au2QWaxfrsuYpxabQleQGsCxLvZFNQKAj9p+VLxJ6VfBG35naH/9zDNCKMu2QBXbQKzhai/ogWSIiiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CN5gE+Eq; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719296654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4bxxUAJuq2rr3KPobPQOBQilwLNETOz0MjNzojnBtM=;
	b=CN5gE+Eq2magNWdd8QrK1zOC3R8bf1KbPZ3NH9ELjsQfumrMQ5gnwKYAZAkzWgr2EYAqBM
	2yVj5cKUrvfKzBc8H6TkGnWbAf8q9duzXXHPtXGf69fs6rCVGhRFZQqAgEZE11RZLM6GES
	5MsvgxqkJjLjP90OPOw5Zo/n8pxt1uM=
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: gourry.memverge@gmail.com
X-Envelope-To: aneesh.kumar@linux.ibm.com
X-Envelope-To: mhocko@suse.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: john@jagalactic.com
X-Envelope-To: emirakhur@micron.com
X-Envelope-To: vtavarespetr@micron.com
X-Envelope-To: ravis.opensrc@micron.com
X-Envelope-To: apopple@nvidia.com
X-Envelope-To: sthanneeru@micron.com
X-Envelope-To: sj@kernel.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: lenb@kernel.org
X-Envelope-To: dave.jiang@intel.com
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: linux-acpi@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: horenc@vt.edu
X-Envelope-To: horenchuang@bytedance.com
X-Envelope-To: horenchuang@gmail.com
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: qemu-devel@nongnu.org
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 06:24:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: horen.chuang@linux.dev
Message-ID: <acf41fe2246f3696a6fe267b8a23bdb4f855cb4e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] memory tier: consolidate the initialization of memory
 tiers
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>, "Huang, Ying"
 <ying.huang@intel.com>, "Gregory Price" <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
 john@jagalactic.com, "Eishan Mirakhur" <emirakhur@micron.com>, "Vinicius
 Tavares Petrucci" <vtavarespetr@micron.com>, "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>, "SeongJae Park"
 <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>, "Dan Williams"
 <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
In-Reply-To: <20240621183413.1638e7453a0bed2af5f44273@linux-foundation.org>
References: <20240621044833.3953055-1-horen.chuang@linux.dev>
 <20240621183413.1638e7453a0bed2af5f44273@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

June 21, 2024 at 6:34 PM, "Andrew Morton" <akpm@linux-foundation.org> wro=
te:

Hi Andrew,

Thanks for the feedback. I will send a v2 with the patch description
written in a cover letter.

>=20
>=20On Fri, 21 Jun 2024 04:48:30 +0000 "Ho-Ren (Jack) Chuang" <horen.chua=
ng@linux.dev> wrote:
>=20
>=20>=20
>=20> If we simply move the set_node_memory_tier() from memory_tier_init(=
) to
> >=20
>=20>  late_initcall(), it will result in HMAT not registering the
> >=20
>=20>  mt_adistance_algorithm callback function,
> >=20
>=20
> Immediate reaction: then don't do that!
>=20
>=20>=20
>=20> because set_node_memory_tier()
> >=20
>=20>  is not performed during the memory tiering initialization phase,
> >=20
>=20>  leading to a lack of correct default_dram information.
> >=20
>=20>=20=20
>=20>=20
>=20>  Therefore, we introduced a nodemask to pass the information of the
> >=20
>=20>  default DRAM nodes. The reason for not choosing to reuse
> >=20
>=20>  default_dram_type->nodes is that it is not clean enough. So in the=
 end,
> >=20
>=20>  we use a __initdata variable, which is a variable that is released=
 once
> >=20
>=20>  initialization is complete, including both CPU and memory nodes fo=
r HMAT
> >=20
>=20>  to iterate through.
> >=20
>=20>=20=20
>=20>=20
>=20>  Besides, since default_dram_type may be checked/used during the
> >=20
>=20>  initialization process of HMAT and drivers, it is better to keep t=
he
> >=20
>=20>  allocation of default_dram_type in memory_tier_init().
> >=20
>=20
> What is this patch actually aiming to do? Is it merely a code cleanup,
>=20
>=20or are there functional changes?
>=20
>=20>=20
>=20> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >=20
>=20>  ---
> >=20
>=20>  Hi all,
> >=20
>=20>=20=20
>=20>=20
>=20>  The current memory tier initialization process is distributed acro=
ss two
> >=20
>=20>  different functions, memory_tier_init() and memory_tier_late_init(=
). This
> >=20
>=20>  design is hard to maintain. Thus, this patch is proposed to reduce=
 the
> >=20
>=20>  possible code paths by consolidating different initialization patc=
hes into one.
> >=20
>=20
> Ah, there it is. Please make this the opening paragraph, not an aside
>=20
>=20buried below the ^---$.
>=20
>=20I'll await review input before proceeding with this, thanks.
>

