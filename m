Return-Path: <linux-acpi+bounces-10303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660D9FC465
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 10:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46AD8188392E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ECC1494C9;
	Wed, 25 Dec 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeSuYF/x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3517BD5;
	Wed, 25 Dec 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735119055; cv=none; b=Q99S/VZUotBy+6qSOVKdtvsNvCJ0KI17SB3PlUe+9K0QP3tlkts/uOEMsG60DJYwXDor1bku7iini6+wd6zj9DxGZn+4yHBjQbFOzhXzQ1s6MXvRZLm7G/glmo3uE+yV9fHhBaLTHS6DzND8VpFm9x8Ucr1ZP9/QH+XL82OjXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735119055; c=relaxed/simple;
	bh=sfs9+qvHYHb2rWX47xveCEYwIewRfXZRUxuHFQZo1pI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZoseA0fg5NCXaIr7oFY+9J/SM2sdQkFEpv1sC/7e+mDd20eFKpR/LTpMNKhsAsgRsjHKfFD3QQvhJUmSYLXIZaUFVICL/6/73YB36Ko2tVIKGiDPmvubtIoGrOBHcESLj8ezRFBUXKwk6t6gkjlpB9OR93YXwJBQ5UJLY6oNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeSuYF/x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21644aca3a0so72428515ad.3;
        Wed, 25 Dec 2024 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735119053; x=1735723853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO97famSWHrEcuq4hlOcC1w64yYzM7UM60pMtM7rK8g=;
        b=TeSuYF/xQAXG6hKrB2Lw7z7eQocL0ACICtrSi/fFt3WkaXmb7ssQd7pbpgbKSUYiDN
         SoTi+d7Bdbr8xGfDKzstxG1S6Q7Cw65+ZHDjL3tCmgzQRWiO7fqjlZVOGs/IfWXpdp5V
         D8r/q4tl3gpyQS0yfguA+1Ct3SsFCY3EJkJ5gjm24dhprDG5nZTDJeF1AMIzH8lK+wLp
         YQX/dZ6VxMYnz+hfBVFGnuY27dsyxaT3Bahq9lIdk2JT+IlIFwL7zLasiP3URcobxR8u
         IgVERQnsk9E1xQBl3kCY8DLz6gbFuvTC6pfHD6FSU68hyGH79v6MaX6TRSk1EJhUyXJ9
         GWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735119053; x=1735723853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AO97famSWHrEcuq4hlOcC1w64yYzM7UM60pMtM7rK8g=;
        b=hW7hiGCNpnvB8LHty3/ejd+XLdew8sRdAv0hGheHW2P1VO25epXDtXNMd7/CAR0Qg8
         QjbCckEcPH5U7fE2mdQSX90P6Jy3gapY6JiVTuEBOt+YlUXQO7PAj5FUCiZE2Wilz2Sg
         se8jLGgTY3NCoE+mnl4o3OGUtw1KrXLutsUE1BwyUpa6+xlzgoOFyIkyjfd6MbLwY1/m
         5XN7rOmex9YGLLtaJC090rOkWdrQoksSzvO7kjnVOKMUOtXJsw55JQsxWf7AhTsHqrEh
         cGHaDu14knbLQeiTLpJWI2NgOx2yeGdXz1HFix9CCDe85YU7KDb7ykGE0fA6pERjsBxJ
         TwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCjty+BzUWKLFpefpj6lbJIqwMADpvtW5A5VR/qMlvlfX+74BtmckfzXo5HIFFiaK6iVSTkG7BQu/OTMPw@vger.kernel.org, AJvYcCXyki4kQWu+kBAG1+uBqBPkBpxW01pdBZBX/7R4O1raXSZrtua2HysX6vnxKFs7NXmuloHjWekC0jvC@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/mG2/RcaT2ZeOp+0g8eNWptdzsk0/tRYudpmv3h0bQiU5rQR
	NU34pOSJ2lZPsPJtZo5IGujUBuhY77jmwL/yNq0PoYMKP0sysgZi
X-Gm-Gg: ASbGncsotcFcLYMJHMMIhGEPCMpgC1sjJp+neiEoznJNOp9MQs30snmniGkRLaPsLWu
	KVZns0c1RsaWMK+jvbsOEslH6hdKWsMzIyidL6kp4TRkjurnOx/QER4YIAMGGWQpnpPCL8rPB7x
	XOT8D2T4ejToYhrVexW/BSzA0vuLEey//xgyosX5upIBUBIO/iWay0sY44xaTpdFX0cMvBgHyop
	cAIfHi2ZJHMosZfirYMD7cGUOA+lCCVu6Kq6Unq91qGH2pGiejbfd3rQrDRfEwgxiEwpC79sjx4
	PfRnntbTH5W97+2k
X-Google-Smtp-Source: AGHT+IE5Xqas8nhS3ukivJ7JRMcaIofPaUbvxgDfDbd0nOxfN+FIpeeIIG0vh84jEBLzk0pYYKKZMw==
X-Received: by 2002:a05:6a20:12d2:b0:1e1:3970:d75a with SMTP id adf61e73a8af0-1e5e0458eadmr34130497637.9.1735119052670;
        Wed, 25 Dec 2024 01:30:52 -0800 (PST)
Received: from localhost.localdomain ([112.169.183.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dd1a8sm11291909b3a.106.2024.12.25.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 01:30:51 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Gregory Price <gourry@gourry.net>,
	hyeonggon.yoo@sk.com,
	kernel_team@skhynix.com,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?utf-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKQ==?= System SW <honggyu.kim@sk.com>,
	=?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave auto-tuning
Date: Wed, 25 Dec 2024 18:30:42 +0900
Message-Id: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <87ed1wa9sm.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gregory and Huang,

Sorry for the silence on my end for the past few days. I decided to take
some time off of the computer, but I should be more reponsive now!

On Wed, 25 Dec 2024 08:25:13 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Gregory Price <gourry@gourry.net> writes:
> 
> > On Sun, Dec 22, 2024 at 04:29:30PM +0800, Huang, Ying wrote:
> >> Gregory Price <gourry@gourry.net> writes:
> >> 
> >> > On Sat, Dec 21, 2024 at 01:57:58PM +0800, Huang, Ying wrote:

[.....8<.....]

> > We decided when implementing weights that 0 was a special value that
> > reverts to the system default:
> >
> >   Writing an empty string or `0` will reset the weight to the
> >   system default. The system default may be set by the kernel
> >   or drivers at boot or during hotplug events.
> >
> > I'm ok pulling the default weights in collectively once the first one is
> > written, but 0 is an invalid value which causes issues.
> >
> > We went through that when we initially implemented the feature w/ task-local
> > weights and why the help function overrides it to 1 if it's ever seen.
> >
> > We'll revert back to our initial implementation w/ default_iw_table and
> > iw_table - where iw_table contains user-defined weights.  Writing a 0 to
> > iw_table[N] will allow get_il_weight() to retrieve default_iw_table[N]
> > as the docs imply it should.
> 
> So, the suggested behavior becomes the following?
> 
> default_values [5,2,-] <- 1 node not set, expected to be hotplugged
> user_values    [4,2,1] <- user has only set one value, not populated nodes have value 1
> effective      [4,2,1]
> 
> hotplug event
> default_values [2,1,1] - reweight has occurred
> user_values    [4,2,1]
> effective      [4,2,1]

Yes, I think this was the intended effect when we were discussing what
interface made the most sense.

> Even if so, we still have another issue.  The effective values may be a
> combination of default_values and user_values and it's hard for users to
> identify which one is from default_values and subject to change.  For
> example,
> 
> user reset weight of node 0 to default: echo 0 > node0
> default_values [2,1,1]
> user_values    [0,2,1]
> effective      [2,2,1]
> 
> change the default again
> default_values [3,1,1] - reweight again
> user_values    [0,2,1]
> effective      [3,2,1]

Agreed. Actually, this confusion was partly what motivated our new
re-work of the patch in v2, which got rid of the default and user
layers, and made all internal values transparent to the user as well.
That way, there would be no confusion as to the true source of the
value, and the user could be aware that re-weighting would impact
all values, regardless of whehter they were default values or not.

If we are moving away from allowing users to dynamically change the
weightiness (max_node_weight) parameter however, then I think that there
may be more merit to using the two-level default & user values system to
allow for more flexibility.
 
> This is still quite confusing.  Another possible solution is to copy the
> default value instead,
> 
> user reset weight of node 0 to default: echo 0 > node0
> default_values [2,1,1]
> user_values    [2,2,1] - copy default value when echo 0
> effective      [2,2,1]
> 
> change the default again
> default_values [3,1,1] - reweight again
> user_values    [2,2,1]
> effective      [2,2,1]

This makes a lot sense to me, I think it lets us keep both the
transparency of the new one-layered system and all the benefits that
come with having default values that can adapt to hotplug events. One
thing we should consider is that the user should probably be able to
check what the default value is for a given node before deciding to
copy that value over to the weight table.

Having two files for each node (nodeN, defaultN) seems a bit too
cluttered for the user perspective. Making the nodeN interfaces serve
multiple purposes (i.e. echo -1 into the nodes will output the default
value for that node) also seems a bit too complicated as well, in my
opinion. Maybe having a file 'weight_tables' that contains a table of
default/user/effective weights (as have been used in these conversations)
might be useful for the user? (Or maybe just the defaults)

Then a workflow for the user may be as such:

$ cat /sys/kernel/mm/mempolicy/weighted_interleave/weight_tables
default vales: [4,7,2]
  user values: [-,-,-]
    effective: [4,7,2]

$ echo 4 > /sys/kernel/mm/mempolicy/weighted_interleave/node2
4
...

> The remaining issue is that we cannot revert to default atomically.
> That is, user_values may becomea  combination of old and new
> default_values if users echo 0 to each node one by one when kernel is
> changing default_values.  To resolve this, we may add another interface
> to do that, for example, "use_default".
> 
> echo 1 > use_default
> 
> will use default_values for all nodes.  We can check whether we are
> using default via
> 
> cat use_default

Like mentioned in the previous comments, I think that the "setting one
value to set all the others" is a good method, especially since the
more I think about it (in my limited experience), I think there is rarely
a scenario where a user wants to use a hybrid of manually-set and
default values and is switching back and forth between default and
manual values.

> Anyway, I think that we need a thorough thought about the user space
> interface.  And add good document, at least in change log.  It's really
> hard to make user space interface right.
> 
> I'm open to better user space interface design.

I agree with this, thank you for your feedback. I think there has been
a lot of great points raised in these conversations, and I will do my
best to take these comments into consideration when writing better
documentation. 

> ---
> Best Regards,
> Huang, Ying

Thank you for your input! I hope you have a great day and happy holidays!
Joshua

