Return-Path: <linux-acpi+bounces-12198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80283A5F948
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7821F7AC1A4
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A3268C76;
	Thu, 13 Mar 2025 15:09:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35B268C5B;
	Thu, 13 Mar 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878594; cv=none; b=ljAk43PiKhhzAw/E4BffHs53HTCmUGzWozwXHbWKJEwwoinTOFajKFukLkSnu+8LbnZ3SwBA+kCMxLW5NPaZ4YPLJPFHsK3UvaaV4kuOMEBKqAz7sDMqHxo18IiNpAE2kVjuf470wgDMXLIVrlpg1cvMhuHew2ovol2dkIQbhPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878594; c=relaxed/simple;
	bh=+iiUyL202c0si2LthRlsePbrvSQoTqyqBToD03RD0Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw9M9BNLF3OJ+icequMHYtOlFqorjKD30J0yAfTkFqfwGm/HLBXQRBrw6zCsBygkTzcN5bsUT1wmRt8JK4pVgJ3DP0mLXgLOsL4D4vmdz1azebjbfdC17/+o3kGbxxIaltUiRLL02uUtpxxsNP2nxjYZjQIxm+bp0b2gm0dzjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C940113E;
	Thu, 13 Mar 2025 08:10:02 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48BB3F694;
	Thu, 13 Mar 2025 08:09:50 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:09:48 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Robbie King <robbiek@xsightlabs.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH v2 02/13] mailbox: pcc: Always clear the platform ack
 interrupt first
Message-ID: <Z9L1PD8lDjwM7L3l@bogus>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
 <4ef4df06-c6f8-4151-96e1-78be58f32f54@xsightlabs.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef4df06-c6f8-4151-96e1-78be58f32f54@xsightlabs.com>

On Thu, Mar 13, 2025 at 11:08:04AM -0400, Robbie King wrote:
> On 3/5/2025 11:38 AM, Sudeep Holla wrote:
> > The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
> > for command completion flags and any error status before clearing the
> > interrupt.
> > 
> > The below sequence highlights an issue in the handling of PCC mailbox
> > interrupts, specifically when dealing with doorbell notifications and
> > acknowledgment between the OSPM and the platform where type3 and type4
> > channels are sharing the interrupt.
> > 
> > -------------------------------------------------------------------------
> > | T |       Platform Firmware         |    OSPM/Linux PCC driver        |
> > |---|---------------------------------|---------------------------------|
> > | 1 |                                 | Build message in shmem          |
> > | 2 |                                 | Ring Type3 chan doorbell        |
> > | 3 | Receives the doorbell interrupt |                                 |
> > | 4 | Process the message from OSPM   |                                 |
> > | 5 | Build response for the message  |                                 |
> > | 6 | Ring Platform ACK interrupt on  |                                 |
> > |   |  Type3 chan to OSPM             | Received the interrupt          |
> > | 7 | Build Notification in Type4 Chan|                                 |
> > | 8 |                                 | Start processing interrupt in   |
> > |   |                                 |  pcc_mbox_irq() handler         |
> > | 9 |                                 | Enter PCC handler for Type4 chan|
> > |10 |                                 | Check command complete cleared  |
> > |11 |                                 | Read the notification           |
> > |12 |                                 | Clear Platform ACK interrupt    |
> > |   | No effect from the previous step yet as the Platform ACK          |
> > |   |  interrupt has not yet been triggered for this channel            |
> > |13 | Ring Platform ACK interrupt on  |                                 |
> > |   | Type4 chan to OSPM              |                                 |
> > |14 |                                 | Enter PCC handler for Type3 chan|
> > |15 |                                 | Command complete is set.        |
> > |16 |                                 | Read the response.              |
> > |17 |                                 | Clear Platform ACK interrupt    |
> > |18 |                                 | Leave PCC handler for Type3     |
> > |19 |                                 | Leave pcc_mbox_irq() handler    |
> > |20 |                                 | Re-enter pcc_mbox_irq() handler |
> > |21 |                                 | Enter PCC handler for Type4 chan|
> > |22 |                                 | Leave PCC handler for Type4 chan|
> > |23 |                                 | Enter PCC handler for Type3 chan|
> > |24 |                                 | Leave PCC handler for Type3 chan|
> > |25 |                                 | Leave pcc_mbox_irq() handler    |
> > -------------------------------------------------------------------------
> > 
> > The key issue occurs when OSPM tries to acknowledge platform ack
> > interrupt for a notification which is ready to be read and processed
> > but the interrupt itself is not yet triggered by the platform.
> > 
> > This ineffective acknowledgment leads to an issue later in time where
> > the interrupt remains pending as we exit the interrupt handler without
> > clearing the platform ack interrupt as there is no pending response or
> > notification. The interrupt acknowledgment order is incorrect.
> > 
> > To resolve this issue, the platform acknowledgment interrupt should
> > always be cleared before processing the interrupt for any notifications
> > or response.
> > 
> > Reported-by: Robbie King <robbiek@xsightlabs.com>
> > Reviewed-by: Huisong Li <lihuisong@huawei.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Tested-by: Robbie King <robbiek@xsightlabs.com>
> 

Thanks Robbie for reporting the issue and testing the fix. Much appreciated!

-- 
Regards,
Sudeep

