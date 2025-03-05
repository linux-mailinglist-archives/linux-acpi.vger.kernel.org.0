Return-Path: <linux-acpi+bounces-11832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88135A4FCE9
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 11:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92203A13D2
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DBE20D4F6;
	Wed,  5 Mar 2025 10:57:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337520D4F2;
	Wed,  5 Mar 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172224; cv=none; b=EviXo2eARQMD8Jlbid2K9xTEYZ59OkLOPNNEPpw0GF1vowhh15S8Qx4wKCqMJ/+HId1bSQslQhJFyXffEZGTmnh/8xp/AgfB19Es8qiZ7q/Dm3FOGZp/rtXD02RhQNR5lQwhaUdViAF09L5AgcYHJ7mJpQZ6Qn22qpf2ItGGDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172224; c=relaxed/simple;
	bh=mrco/RzekvTHy487FxzhCRx/OWTRv0gpgdCmg9NHjWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnQj+8k8DnP8tbaU9jlZoJdIMvYV2Fc8R1+u2ax6j4AFbHy1FrOT1GafN4X3o4Z7lWytSny2ormrkrUS3JuTJyEa7YV6alSpUaYk4BjD/c1lzU25rMOFw2HMNBjPDIYsGEZqEVm80ebSO0/mUcl6P9ZnfILx2Rl2Yh0SMNFZONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91840FEC;
	Wed,  5 Mar 2025 02:57:14 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 523333F673;
	Wed,  5 Mar 2025 02:57:00 -0800 (PST)
Date: Wed, 5 Mar 2025 10:56:57 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 07/14] mailbox: pcc: Move pcc_mbox_ioremap() before
 pcc_mbox_request_channel()
Message-ID: <20250305105657.z637peejnkai7fgn@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-7-3b44f3d134b1@arm.com>
 <5738e05f-fa1c-0aa7-78f3-3d38f9f0ae3c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5738e05f-fa1c-0aa7-78f3-3d38f9f0ae3c@huawei.com>

On Wed, Mar 05, 2025 at 02:48:13PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/3 18:51, Sudeep Holla 写道:
> > In order to add support of mapping the generic communication shared
> > memory region in the PCC mailbox driver when the PCC channel is requested,
> > we need to move pcc_mbox_ioremap() before pcc_mbox_request_channel().
> This patch is supposed to merge into patch 8/14 because it depend on this
> moving.

Not sure what exactly you mean. This is 7/14 and 8/14 depends on it which
falls in natural order. Or do you mean just merge the patch into one. I
can do that as well, just kept it separate to easy the review. Let me
know. I thought keeping it separate is good for bisectibility in case
I break anything with these change 😉.

-- 
Regards,
Sudeep

