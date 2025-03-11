Return-Path: <linux-acpi+bounces-12089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC419A5C12C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2C318892C4
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246625A2C0;
	Tue, 11 Mar 2025 12:25:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00172580ED;
	Tue, 11 Mar 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695919; cv=none; b=MerWH8y6cR7gL/UGFZYnxN9YAinZ4UjTtn2Hd0PNMhxB+EEY5hIozIGtfYUpF+kp60bfzPKy92264G9lSetJ8lmV7Yrm6RP0241iYvRUvTefQuSHhwjSroKXf66kHkj9YNwXEgG2bMlnXW0K8hFjyzg35Pkg/s0EjpFor00nw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695919; c=relaxed/simple;
	bh=gFvfYMctZ4OAT7rGtCAhS7uMDp226+536WqOD5+YwPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVt+KtYGvzWJUoqj6ips+1LiW6TOFg0PyLjFAD9mTjb6/ypDQ0qf/k6TCD3Twre/QiecltV9d/u38ZnBiSv4Kbwqmc+uWgrvvTQUDE0MGMijOq7ChxpuXtg+08EDy1Z5aNIbSjbQfiTcWLaOdr7KE1ULV9zXmwsMPjLVj+pMPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22650152B;
	Tue, 11 Mar 2025 05:25:28 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20533F673;
	Tue, 11 Mar 2025 05:25:15 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:25:13 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
Subject: Re: [PATCH v2 08/13] mailbox: pcc: Refactor and simplify
 check_and_ack()
Message-ID: <Z9ArqT6IXf6xckMa@bogus>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
 <34bdfee2-4780-f45b-7891-e845b13fdd2f@huawei.com>
 <Z9AnsaoxypL6qult@bogus>
 <8361a849-2b3d-a5d2-464f-da597f0e2516@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8361a849-2b3d-a5d2-464f-da597f0e2516@huawei.com>

On Tue, Mar 11, 2025 at 08:19:32PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/11 20:08, Sudeep Holla 写道:
> > On Tue, Mar 11, 2025 at 07:47:39PM +0800, lihuisong (C) wrote:
> > > 在 2025/3/6 0:38, Sudeep Holla 写道:
> > > > The existing check_and_ack() function had unnecessary complexity. The
> > > > logic could be streamlined to improve code readability and maintainability.
> > > > 
> > > > The command update register needs to be updated in order to acknowledge
> > > > the platform notification through type 4 channel. So it can be done
> > > > unconditionally. Currently it is complicated just to make use of
> > > > pcc_send_data() which also executes the same updation.
> > > > 
> > > > In order to simplify, let us just ring the doorbell directly from
> > > > check_and_ack() instead of calling into pcc_send_data(). While at it,
> > > > rename it into pcc_chan_check_and_ack() to maintain consistency in the
> > > > driver.
> > > LGTM except for some trivial,
> > > Acked-by: Huisong Li <lihuisong@huawei.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >    drivers/mailbox/pcc.c | 37 +++++++++++++------------------------
> > > >    1 file changed, 13 insertions(+), 24 deletions(-)
> > > > 
> > > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > > > index b3d133170aac7f8acfd1999564c69b7fe4f6d582..90d6f5e24df7e796f8c29705808eb6df2806c1f2 100644
> > > > --- a/drivers/mailbox/pcc.c
> > > > +++ b/drivers/mailbox/pcc.c
> > > > @@ -117,8 +117,6 @@ struct pcc_chan_info {
> > > >    static struct pcc_chan_info *chan_info;
> > > >    static int pcc_chan_count;
> > > > -static int pcc_send_data(struct mbox_chan *chan, void *data);
> > > > -
> > > >    /*
> > > >     * PCC can be used with perf critical drivers such as CPPC
> > > >     * So it makes sense to locally cache the virtual address and
> > > > @@ -288,33 +286,24 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
> > > >    	return 0;
> > > >    }
> > > > -static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> > > > +static void pcc_chan_check_and_ack(struct pcc_chan_info *pchan)
> > > How about use pcc_chan_ack?
> What do you think of this?

Sure I can update, just retained what was there and made it consistent
with other functions.

-- 
Regards,
Sudeep

