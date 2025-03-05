Return-Path: <linux-acpi+bounces-11835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E514AA500B7
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA53A91C3
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33602248885;
	Wed,  5 Mar 2025 13:37:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3E248881;
	Wed,  5 Mar 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181874; cv=none; b=jFqTRrGZjsf5ZZSf9kG4hrF/NihBvcdwptVkPzW8yZ5+y/pFzAeMfaVrVQQyEq0QmoVdOmouNGZXC6wnVq6qzi5IdmFd0DZgc7Vif2mYboRnBQQV84IGw9n1ITyRdF/bgVTaOfGkq6oahT/IVad2KKKH7ha8sOugP6gzfq/Bu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181874; c=relaxed/simple;
	bh=O/4Yv9lIZncJ09nkruqjIwoGGbRpOW+EpIkMZByOw64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3CjH/9723XfFEtcMOcy2kJghv61/Hvuq0HXte/FAwrTdWO43THSFMcDP+FmWkOrquYjWuRcbXbM3omVjomgXXjHv2o9sjNQS5dkUWflDRHcG8yP0WPARRxuhrtHn43LydnY2dq4JaMmMDzBrc25tTiCuHmPEkjHQwCTIO+vppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 376EDFEC;
	Wed,  5 Mar 2025 05:38:03 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E00A3F66E;
	Wed,  5 Mar 2025 05:37:48 -0800 (PST)
Date: Wed, 5 Mar 2025 13:37:45 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 07/14] mailbox: pcc: Move pcc_mbox_ioremap() before
 pcc_mbox_request_channel()
Message-ID: <20250305133745.f2q7nx3ux6w5xxhz@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-7-3b44f3d134b1@arm.com>
 <5738e05f-fa1c-0aa7-78f3-3d38f9f0ae3c@huawei.com>
 <20250305105657.z637peejnkai7fgn@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305105657.z637peejnkai7fgn@bogus>

On Wed, Mar 05, 2025 at 10:56:57AM +0000, Sudeep Holla wrote:
> On Wed, Mar 05, 2025 at 02:48:13PM +0800, lihuisong (C) wrote:
> > 
> > 在 2025/3/3 18:51, Sudeep Holla 写道:
> > > In order to add support of mapping the generic communication shared
> > > memory region in the PCC mailbox driver when the PCC channel is requested,
> > > we need to move pcc_mbox_ioremap() before pcc_mbox_request_channel().
> > This patch is supposed to merge into patch 8/14 because it depend on this
> > moving.
> 
> Not sure what exactly you mean. This is 7/14 and 8/14 depends on it which
> falls in natural order. Or do you mean just merge the patch into one. I
> can do that as well, just kept it separate to easy the review. Let me
> know. I thought keeping it separate is good for bisectibility in case
> I break anything with these change 😉.
> 

Scratch that, after reworking 8/14 as per your suggestion made me realise
what you meant. Sorry for that. Dropping this patch entirely now.

-- 
Regards,
Sudeep

