Return-Path: <linux-acpi+bounces-11829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E78CA4FC5A
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DD97A35A1
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46B207673;
	Wed,  5 Mar 2025 10:36:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61642063F2;
	Wed,  5 Mar 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171014; cv=none; b=iR4iXpnabN3jZlPzJQIltvS/TDa86jE/5r6gL39lJXQXls4xkWzRTmb0umOOf8cCT11ywxPMvFUOZEeKCZTt2d3ZuTDum6CPNGAsBlDEMJvMNZgxV6AaMcBZaGWEJrPogFbifoI0Or9UWLWRRvBJ+6lCebqSTBA5v9vPxbC7Blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171014; c=relaxed/simple;
	bh=xUctAWGKbbNWM8E5A2NXPQGDPvrVmG4lSKCcjM20LEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNciQoWOCRO2OrcjKI0j08x2j9/p6ARcTmHKycdmTjJwKn9dnKaxTe6rUqWg//uPl/QoY6uWu/E3kyg3jC4eLP72sK4r39JWQdTbhwzMt6KZdZV5eMKwxG980jkciG5RuzbQgTsQLitJcGBxX8aC2ZiaodwpjtN5qosUHPqQlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7606CFEC;
	Wed,  5 Mar 2025 02:37:05 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D8B13F673;
	Wed,  5 Mar 2025 02:36:51 -0800 (PST)
Date: Wed, 5 Mar 2025 10:36:48 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 03/14] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
Message-ID: <20250305103648.7e2ajxlkwza7axzc@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-3-3b44f3d134b1@arm.com>
 <5093286f-1db6-bab2-920d-71fe274ad251@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5093286f-1db6-bab2-920d-71fe274ad251@huawei.com>

On Wed, Mar 05, 2025 at 12:02:13PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/3 18:51, Sudeep Holla 写道:
> > The Sparse static checker flags a type mismatch warning related to
> > endianness conversion:
> > 
> >    |  warning: incorrect type in argument 1 (different base types)
> >    |     expected restricted __le32 const [usertype] *p
> >    |     got unsigned int *
> > 
> > This is because an explicit endianness conversion (le32_to_cpu()) was
> > applied unnecessarily to a pcc_hdr.flags field that is already in
> > little-endian format.
> > 
> > The PCC driver is only enabled on little-endian kernels due to its
> > dependency on ACPI and EFI, making the explicit conversion unnecessary.
> How to confirm ACPI works only on little-endian?

Sorry I didn't notice this question. ACPI depends on ARCH_SUPPORTS_ACPI
and it is selected only from EFI which is disabled if CPU_BIG_ENDIAN=y

--
Regards,
Sudeep

