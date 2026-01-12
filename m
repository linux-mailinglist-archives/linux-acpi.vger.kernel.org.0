Return-Path: <linux-acpi+bounces-20209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C529DD14363
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 17:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 560D9302EA06
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E936E486;
	Mon, 12 Jan 2026 16:55:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB1236E46D;
	Mon, 12 Jan 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236905; cv=none; b=YXqZxO7xS4WseWwuXh73GQIPWnoU1ZmxeU3os5RYsd1v2VSXxIgkXn5ndw75Rvqdf5xXyCREjBK9O1cTwboZagrFnnwIh5qh7kd1Vdbe/vf7H+hxeyE/Wil81ZFCfDl4hkX84IbgOFE9PDOIEOi32qjdR9sHMbYY2QbwHs5FCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236905; c=relaxed/simple;
	bh=xTuh/PlmjjN9iikFJhESqaPl3ugVibxFxYaltFM3DPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKUqz6w3lTqlJePaErPA6JnZ/1xmSYyweQZC1qEckp1iq8x0PCksxEI2ZO5Z2BWxA70Y3tpwFRUkM6UZ7YH40Ab4JuezM6KbmZ8ng7OIAkhN1iDMHVpXnV0HjRGWVhdk+eS0b17EEGjLhJ+7Y6aPrKkegViV/iFwhVHDutMpmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD72B497;
	Mon, 12 Jan 2026 08:54:56 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87B723F694;
	Mon, 12 Jan 2026 08:55:02 -0800 (PST)
Date: Mon, 12 Jan 2026 16:55:00 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Huisong Li <lihuisong@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation
 and interrupt handling
Message-ID: <aWUnZJ83_AKQDagu@bogus>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>

On Thu, Nov 27, 2025 at 02:40:56PM +0000, Sudeep Holla wrote:
> Hi Jassi,
> 
> On Thu, Oct 16, 2025 at 08:08:14PM +0100, Sudeep Holla wrote:
> > This series refines and stabilizes the PCC mailbox driver to improve
> > initialisation order, interrupt handling, and completion signaling.
> > 
> Are you happy to pull these patches directly from the list or do you
> prefer me to send you pull request or do you want me to direct this via
> ACPI/Rafael's tree. Please advice.
> 

Hi Jassi,

Sorry for the nag. I did see these patches in -next as well as your
v6.19 merge window pull request which didn't make it to Linus tree.
However I don't see it -next any longer. Please advice if you want
anything from my side so that this can be merged for v6.20/v7.0

-- 
Regards,
Sudeep

