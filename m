Return-Path: <linux-acpi+bounces-11118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F1A329C1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50CF1885B76
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9AD20F07E;
	Wed, 12 Feb 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnV1QOob"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208F27183C
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373538; cv=none; b=PwkkPgYinA5nZGRp7diqu9ZohvYAT0kAkeSwN+kpcqxie3iw+GzR4yeq9r2b7UVBWM7dpMEYV2PAxHxbWJPULgrmkKaHK8NmVcB+hDKRfBFodXPzhfoNfYqzOAxPi30fACeWz8m8CSgEReAXOVPkCyw6zxUtChty728fSx3iAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373538; c=relaxed/simple;
	bh=OZYS+bw8dGR7sBHWnvXlqu58j2nZztUGaAzgn3apUOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV8fQvc1P8J/PRcqOb7FzUtjs3PvrYuAazi8SjM4PlsDppwrLtfiqQ8dp4peVLCgzB8c12/C/6Utno1AYfV2M7ny2xuzsTbtcOxtu1lIo+81dOIIRz6bmtFFz1W7gvuUnYdAQvETzmKHgg2bEKIQCrfVemOyXcz7/kZN9fKAdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnV1QOob; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e4419a47887so5360219276.0
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 07:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739373536; x=1739978336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp8cQDra8OkL311R2+pzj/CpnjokURMQ7dsZUkJXkWc=;
        b=SnV1QOobnqdpaMNMrryMwV/brM8Yn2k0NibhWhLDxlxp5PK7RK+28sgrFOvCPts47A
         9aOzRgiKJ7GamIvddkmv/5jLhsp1d75ep18YYD5Dxb0jfDbu2KGApivsQbmjyzn9praP
         nffEupoQs2hfTUiGix5IvS+IJLDxiAtQ1RA605tsj+AnyN4qYl+0NMfFxt6nop97+MpS
         pLlKTcNDjgztSeWplWyyDRsQeDSSGoijmQ6aW940wbFergOmstWz3d1/Y8a8bteoL7tL
         bdbrfeV5DvUMq7blWuTWpFlAFUXleHGRJRV3SkgcQYe1vUGsVdZguKEud1pztjsccrS5
         uY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373536; x=1739978336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp8cQDra8OkL311R2+pzj/CpnjokURMQ7dsZUkJXkWc=;
        b=lX8pnqK9Nzwn/CU39nhsOALTmsKUWq/k8M0ZpJY+IfRJMSPpPCkuiBJlE5NSKxOkY/
         HqJOtUxZ/5NqA6ZmpcyjAGtqOrD+fAUgBDtMq4THJSLCFMfS+arO53w0xvM1yS1amg+i
         yfXXBoeffkL8boJDHaPKlZ4+RjlB0xcyp4k6xUstJJ+jDOaNk0R4PQS9QChIrpxZ1cz7
         PWLgcA7QrQqSSq+P+JciNW6QlgdTTZ1OaDJA8ecabUQweuqzgWMAHeKAov+aUJe8+9DX
         eMMsqjT26yrRlk0aDPwrP4jm12SZKidFAS6etkXyz1aviip4Vz3XDMkPwBP8busbEpWZ
         OfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU8Y1A8GyoPL2mZFNNnt/zB21mvXRQe6Xfu+Hyo+x5F5nQuzd6ORpdghteZb5ZK70CD8hfXoO31DY6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+VIBmVBdU+YbYdyOGDLyr+zgociq7OKnRU34zXGdL+ot4Jy5
	IhFz20U1SLxMzTNIDQN46Voue/W8GS2oKsh8p7deWCyVpOTogsnr
X-Gm-Gg: ASbGncscPcbe35yUp95t1EODR/7OhbM9oNVbogrwCNB5/Z8KoDBFRsjBXpoo6VOGwkj
	OI2IxpnFsEGBC0rVVBmR8QRTbdhzWi2rWkNhuJnAVGiw8P9vdCgakNpB0YuhvD8VVxUWZalfuh2
	+8gRE8rZkj8wyFil280AWGRdIuikrO67xg3YHNSzLPQYt3Z+onk+bv6ftIUqu8/5WuVL4lfHgVS
	QbO+DwXXGYZ7ttIYlN9pTnBqcLNFOt31rfvyvV+ZHj4ATk0Q1AYbJf3mTb+FGEqpUX+cSZMywNX
	NaLwwdjkc80Krw==
X-Google-Smtp-Source: AGHT+IGMwadjZHoGhSUXMKY5vAmet1Qy5D8eOpNPMmyRHPyHJVzSGMHqfW+0IQffQ9kqcx9zQKFODQ==
X-Received: by 2002:a05:6902:1607:b0:e5a:e604:78df with SMTP id 3f1490d57ef6-e5d9f0faae2mr3681894276.17.1739373535939;
        Wed, 12 Feb 2025 07:18:55 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5da4522daesm271670276.0.2025.02.12.07.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:18:55 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Wed, 12 Feb 2025 07:18:33 -0800
Message-ID: <20250212151852.526233-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <Z6b--rdWJD3UQDI-@localhost.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 8 Feb 2025 07:51:38 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> On Fri, Feb 07, 2025 at 12:13:35PM -0800, Joshua Hahn wrote:

[...snip...]

> Hi Joshua
> 
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 0ea653fa3433..16e7a5a8ebe7 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/init.h>
> >  #include <linux/mm.h>
> >  #include <linux/memory.h>
> > +#include <linux/mempolicy.h>
> >  #include <linux/vmstat.h>
> >  #include <linux/notifier.h>
> >  #include <linux/node.h>
> > @@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
> >  			break;
> >  		}
> >  	}
> > +
> > +	/* When setting CPU access coordinates, update mempolicy */
> > +	if (access == ACCESS_COORDINATE_CPU) {
> > +		if (mempolicy_set_node_perf(nid, coord))
> > +			pr_info("failed to set node%d mempolicy attrs\n", nid);
> 
> Not a big deal but I think you want to make that consistent with the error
> pr_info? that is: "failed to set mempolicy attrs for node %d".

Hi Oscar, thank you for reviewing my patch!
That sounds good to me. Then that line can be replaced with
pr_info("failed to set mempolicy attrs for node %d\n", nid);

> Also, I guess we cannot reach here with a memoryless node, right?

I think that they should not reach this line, but since memoryless
nodes do not have any memory bandwidth / latency information, it should
be fine. With that said, I think a check like the following would
make this more explicit and possibly guard against any unexpected
calls to mempolicy_set_node_perf:

- if (access == ACCESS_COORDINATE_CPU) {
+ if (access == ACCESS_COORDINATE_CPU && !node_state(nid, N_MEMORY)) {

> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 04f35659717a..51edd3663667 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -109,6 +109,7 @@
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/printk.h>
> >  #include <linux/swapops.h>
> > +#include <linux/gcd.h>
> >  
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> > @@ -138,16 +139,18 @@ static struct mempolicy default_policy = {
> >  
> >  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
> >  
> > +static uint64_t *node_bw_table;
> > +
> >  /*
> > - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> > - * system-default value should be used. A NULL iw_table also denotes that
> > - * system-default values should be used. Until the system-default table
> > - * is implemented, the system-default is always 1.
> > - *
> > + * iw_table is the interleave weight table.
> > + * If bandwidth data is available and the user is in auto mode, the table
> > + * is populated with default values in [1,255].
> >   * iw_table is RCU protected
> >   */
> >  static u8 __rcu *iw_table;
> >  static DEFINE_MUTEX(iw_table_lock);
> > +static const int weightiness = 32;
> 
> You explain why you chose this value in the changelog, but I would either
> drop a comment, probably in reduce_interleave_weights() elaborating a
> little bit, otherwise someone who stumbles upon that when reading that
> code will have to go through the changelog.

I also think this feedback makes a lot of sense. Maybe something like:
/*
 * 32 is selected as a constant that balances the two goals of:
 * (1) Keeping weight magnitude low, as to prevent too many consecutive
 *     pages from being allocated from the same node before other nodes
 *     get a chance
 * (2) Minimizing the error between bandwidth ratios and weight ratios
 */

Andrew -- I will send over a new v6 for this patch, if that is alright with
you. I will also probably wait a few days before sending it out, in case
there are other changes that folks would like to see. Please let me know
if this works for you / if there is something ele I can do to make this
process smoother.

Thank you again! Have a nice day!
Joshua

> 
> -- 
> Oscar Salvador
> SUSE Labs


