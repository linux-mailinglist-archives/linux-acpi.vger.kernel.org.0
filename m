Return-Path: <linux-acpi+bounces-11833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2EDA4FDA4
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC86170217
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E1F21519F;
	Wed,  5 Mar 2025 11:32:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996BA2E3381;
	Wed,  5 Mar 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174326; cv=none; b=TEo9dT4Usg7rNHsz5zzmsseoJZqmag20D8rQuflCQAZ+JH0/8ckprh7qkg+JGgpS7ldBQvfGUrhl28ne/gpp3tXWIUWlNAFRPWO8giTx6XfNDNHuEez8w6DfaZQBTLfJSaI/FKaQNw8wbXuln4eQw5PnmSdSABMpHklARQKAtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174326; c=relaxed/simple;
	bh=AZoGCEfOTk8deKxM5br9HdLjOA0MrSeiJkCs/vdWUxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUZrr85Nc2PxJlcLTe2SzkOKXyAor8oUrgzwEeE5pDPd3wC5TKVE1tION3HiOgbjquMZLl4F+Xri74eW8GguS9vr1Qt3N7MIu5xObW93TbGpTCuf8rLTU9XjTzNdGd40UvR6ynMuB0d5I8889t8ZD4h4ljCJurG6gKeOk+CR8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40EDCFEC;
	Wed,  5 Mar 2025 03:32:17 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02DB63F673;
	Wed,  5 Mar 2025 03:32:02 -0800 (PST)
Date: Wed, 5 Mar 2025 11:31:59 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 08/14] mailbox: pcc: Always map the shared memory
 communication address
Message-ID: <20250305113159.hi6lelre2sphigz4@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-8-3b44f3d134b1@arm.com>
 <fc45c6c7-6828-d36e-3bb1-9f90fec01b45@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc45c6c7-6828-d36e-3bb1-9f90fec01b45@huawei.com>

On Wed, Mar 05, 2025 at 02:54:39PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/3 18:51, Sudeep Holla 写道:
> > Currently the shared memory communication address was mapped by the
> > mailbox client drivers leading to all sorts of inconsistencies.
> > 
> > It also has resulted in the inconsistent attributes used while mapping
> > the shared memory regions.
> > 
> > In order to remove/eliminate any issues, let us ensures the shared
> > memory address is always mapped and unmapped when the PCC channels are
> > requested and release.
> > 
> > We need to map them as the ACPI PCCT associates these shared memory
> > with each channel subspace and may need use the headers in those
> > memory to manage the transport.
> > 
> > Since there are no users of pcc_chan_ioremap() and also it is mapped
> > by default, we can stop exporting it and make it static function.
> 
> If pcc_chan_ioremap is static function, I think we can delete this function
> which just has one line if put this to pcc_mbox_request_channel().
> 

Makes sense, didn't notice while I was cleaning other things around it.

-- 
Regards,
Sudeep

