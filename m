Return-Path: <linux-acpi+bounces-12980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27747A86151
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 17:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A177BA657
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429CF20AF6D;
	Fri, 11 Apr 2025 15:07:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196E1FBEA6;
	Fri, 11 Apr 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384071; cv=none; b=Ur0q4FkdXBGDC4+q+S6zpYFeAXZm7vG0wmieon1xvwzD7kAmcb0bjohhBdDIBmpa+SdkBDHC+3lzDdzdyIJzNIQ8YAfkTEPTjjWvVIpCA/e5Y+L0yNae+I4Qrgm/aYjDrQlWHyR2COtXqOZeBsZcDFFaXDn+Y+6r+eJIbnrxgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384071; c=relaxed/simple;
	bh=ilVcP95pO6GOl3XMTqH0fCiyL4mHYa7YuNVeE44k9Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7mh/hiIdM22XcmS9w4s60VdKNgxUnlLn2v9DNxCINIQpHE+jJzYVJSRLUY947M5W1zu9H4Yjh41gYeFgZPPZp1vufAxPe1PyE5g0PQew8cgUdiEuBrH9l6y+6zLDvfW6k5jFMkVLVBluzSU9H2Nn6lA1SFVa/Iwm7gi3fNPe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748B71007;
	Fri, 11 Apr 2025 08:07:48 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F053F59E;
	Fri, 11 Apr 2025 08:07:47 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:07:44 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 11/13] hwmon: (xgene-hwmon) Simplify PCC shared memory
 region handling
Message-ID: <20250411-able-rattlesnake-of-calibration-fcdcd8@sudeepholla>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
 <20250313-pcc_fixes_updates-v3-11-019a4aa74d0f@arm.com>
 <0be30d7d-f091-4497-bb72-fdcad276285e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be30d7d-f091-4497-bb72-fdcad276285e@roeck-us.net>

On Fri, Apr 11, 2025 at 07:15:22AM -0700, Guenter Roeck wrote:
> On Thu, Mar 13, 2025 at 03:28:57PM +0000, Sudeep Holla wrote:
> > The PCC driver now handles mapping and unmapping of shared memory
> > areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> > this xgene hwmon driver did handling of those mappings like several
> > other PCC mailbox client drivers.
> > 
> > There were redundant operations, leading to unnecessary code. Maintaining
> > the consistency across these driver was harder due to scattered handling
> > of shmem.
> > 
> > Just use the mapped shmem and remove all redundant operations from this
> > driver.
> > 
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Not that it matters, but I keep wondering: Why don't people use auxiliary
> devices for situations like this, and keep the subsystem code where it
> belongs ?
> 

Good question. I haven't used auxiliary devices but did looks at it recently
when I stumbled across some x86 telemetry code just last week. I need to go
and understand it better to see how it can be used here as I don't have much
understanding ATM other than its uses in GPU and Audio subsystems.

> I am not requesting that you do it, I just wonder why the mechanism isn't
> used. I would have thought that it would be perfect for situations like
> this, so I guess I must be missing something, and I'd like to understand
> what that something is.
> 

Not sure, just that no one spent time think about it and see what is missing
if any and make it work.

-- 
Regards,
Sudeep

