Return-Path: <linux-acpi+bounces-12081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF0A5BFD7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7DB189714B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D7C25487F;
	Tue, 11 Mar 2025 11:57:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE625484B;
	Tue, 11 Mar 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694224; cv=none; b=guDGY+qZ6OL4onX0NpDoFnGyTAYsqkuN1Hc39pQ8u/i+LeHBQ3n6a9RyvGW8hof85kzUki/758/i9pBRm7dXHmmNaI7WkQ7KJfoJNonCXv4kg1HunkS/mbq/73OtQPbOp0WibNqjg5N0jZM/UPM0fUxje7DW1E1AWwC57MR27Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694224; c=relaxed/simple;
	bh=6tLKVC8o5+18lHdZOJWSNGcVwXUG7agr0bxrrZ3Ba5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRKE4dp41s1OI5sJ74ajO6da55mqTJRmEDD7ri8cZPg0kntd4Spgo1aWAHxfZ0YvZsni3/XZxiF1jrQBMnAN1GnW4fNCJwMNiLLJz9kNnVevC0Z12hofdZCtfudlunBvWZgT10G1YWXKZKqdGZ54QHnPHxSKEaF0u53IQRQQPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5455D152B;
	Tue, 11 Mar 2025 04:57:13 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FE553F673;
	Tue, 11 Mar 2025 04:57:00 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:56:58 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
Subject: Re: [PATCH v2 07/13] mailbox: pcc: Always map the shared memory
 communication address
Message-ID: <Z9AlCkgrnlka36SJ@bogus>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-7-1b1822bc8746@arm.com>
 <0552e10d-acde-33cd-7f9c-5d7b28fee735@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0552e10d-acde-33cd-7f9c-5d7b28fee735@huawei.com>

On Tue, Mar 11, 2025 at 07:32:34PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/6 0:38, Sudeep Holla 写道:
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
> > with each channel subspace and may need use the status or the flags in
> > the headers of those shared memory communication address regions to
> > manage the transport/channel.
> > 
> > Since there are no users of pcc_chan_ioremap() and also it is mapped
> > by default, we can stop exporting it and merge the functionality into
> > pcc_mbox_request_channel().
> There are two ioremap for the existing mbox client driver after this patch.
> The existing mbox client driver would not use this variable, and no one else
> uses it. So it is safe, right?

IIUC yes, it should be fine.

> Do we need to make a statement that the two iommaps have no impact on the
> existing mbox client drivers?

We can add one, but again it will be become obsolete once we change driver
to use this new mapping. That's why I didn't add it. We can merge all the
changes together if that is the concern. I am fine either way.

Thanks a lot for all the review and testing.

-- 
Regards,
Sudeep

