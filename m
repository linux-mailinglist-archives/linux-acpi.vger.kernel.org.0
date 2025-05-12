Return-Path: <linux-acpi+bounces-13686-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67560AB3A81
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 16:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EFF462161
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0A215F72;
	Mon, 12 May 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQL/zkOM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C021578F;
	Mon, 12 May 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059916; cv=none; b=twovr1POrdrbrRA9ERRw+kv66Ihpxssj4bK69HKNTpKMC0xaOVffPjMplTiEIjfgkoax2IxAg3bal4pwt1Dy6J+4k2Ag1QUNfh8Rpkyxu94+mPz91sDsjr6S7Z5w2pUbbznlNgS+j/rDprGls09yeOzSistPW3zledYRrV1yQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059916; c=relaxed/simple;
	bh=oUlvs94RBEXAj4to71NbS+RWY1nXlo5GOjnk4NPjH1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R683ZzD/7DsK7CF9nTD6vRiPMRpr0ryb6rvOMTBo33RlgoambLLjf8VwOUQ83bl3+xCkR70Br88H7CKgLFvJ0elMnxYFXCRHA2C/7ZxoF7ya0W4tOrFlhfrlMfAZDuGJmWLvDj3ggyCTPqSx6mmHoh85+cNgIFfDUUcxmIuNAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQL/zkOM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7082ad1355bso37794737b3.1;
        Mon, 12 May 2025 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747059913; x=1747664713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZbRl8KS+BWf2EIYeCK4PxGhnOATtqeKgkvhRlCYPQw=;
        b=AQL/zkOMIVJmsCuccWzm1+szFHa/q/K0QgbRXxlf4wY1Fju79K3oS8FY2PAoNhea0O
         ywH2rYhTsMzhTSzXIhcNSfMZazsAfUUZIfyKmx66UdMbgGWNmE6oVTeQ+ol1vcwmcXxd
         3tQELtWyzCgF922r4yId/9eGnsBelxADAj3HzguxYEiFju1lG1luO6nRezsFj6lsIPhX
         Cm8GT4DBa2NFCM02xld5BpA4+kVgQQkbU5RIGNlLL+FRHI8Q/kUWM/AswjByRaW0IcBE
         9LyFwNN8H/pubzB/hhU7fxL1p/krtTIAsPg5k1UmJ8YC5GdX9YMhtjgmglAAxg38DD+A
         Js2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747059913; x=1747664713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZbRl8KS+BWf2EIYeCK4PxGhnOATtqeKgkvhRlCYPQw=;
        b=aCmH8LKVEmlOo35a9CL01A573Xn1gIH2FnZ7gh5Jhv0DweCWqSV4uduFThd8YiAzcw
         P6AY7CiQMFreV8j/5VX1BXf0etIHbCUSSdgF9joD8133GNU79wS7j7XkLiXQWPrk7tPR
         O5GrNb6DOzca1K7eDzTAEfoAw1PONZdg5Ib5BzpDw6cEPB/rV+dx/jOxym/I0m2tf/6I
         ayv/eJnADcu+M8efonxrBa7w5Dix0vMON9OHuwVIjufuRhXcYFSOpZxWFYoTGhLfc13Z
         /AX6BkTHREsxBYEDDdQQwYJ+fa6ts+HR6KTqyrqWnrkhvOd3sm0R4qQMGfndfWOtr4cz
         rzlg==
X-Forwarded-Encrypted: i=1; AJvYcCUUXAgtSURlRBWVunK7T3sPH/LrTmcCvQRO5Xh77gU+kGxXYZknI7MiuVidRg5ZtGRBOwpqdl7+JMaZ9Oon@vger.kernel.org, AJvYcCUr6BWSOiCAU0SaS+heov62jINjxaKBZinEqWFrg5AJvKtFjuKbWCbNwsNsJbuOLy5E028FmeTs8bxY@vger.kernel.org
X-Gm-Message-State: AOJu0Yywi3hBUXcbz5W1fJPLO9edRN3BfJ8ufodJchBn4CJa85iljXi+
	LhWtaO/zGVECMj2NZ4ab2TLewzizYzI1YAfCQsOfyVj/HHjeBJ4B
X-Gm-Gg: ASbGncs5WXKgdFJKOEt289ExxLoC0ld7nVPO3tsVDxPoMIOQIFY0clgKRPRZGNrQiVC
	VcY/MFtf0ysbOrM5zTF6wmuHxs1JPlHeTwM6CcUiK9sFQO4V7/D0OzbMA565IpcTQmwSffVoHI4
	kbVvr7UQGQy8WB72q9BRKJ90yBrMTtusLNES0j7tC0z/xX79ooB0YeBrsWzuK8MtTjJrF816wOu
	43sj6hMlRtIU5F9sFCpeUyKKeq0KdFQ2VS2AfzikE05xkAQp6a/bG0gXEJ0w6+xN3dwAO0DBifB
	zN4h3PxQEIjHgaBMJ203NgnKBu6rfjgLygRiyEcIaKva8O9PXg==
X-Google-Smtp-Source: AGHT+IGPXvFglFcBwoDsiyaAhXCH6w3uRi1CS1sCn8IeFG9vKgl1qLkLZR6tArD3ragmQdU3BAw4QA==
X-Received: by 2002:a05:690c:6c89:b0:6ef:6f24:d093 with SMTP id 00721157ae682-70a3f9eab47mr190835947b3.6.1747059913522;
        Mon, 12 May 2025 07:25:13 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d89a2cfsm19522327b3.12.2025.05.12.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:25:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	gourry@gourry.net,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Mon, 12 May 2025 07:25:10 -0700
Message-ID: <20250512142511.3959833-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <87zffizk4r.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 May 2025 09:35:16 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Hi, Joshua,
> 
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> [snip]
> 
> > @@ -3707,8 +3720,12 @@ static void wi_state_free(void)
> >  	kfree(&wi_group->wi_kobj);
> >  }
> >
> > +static struct kobj_attribute wi_auto_attr =
> > +	__ATTR(auto, 0664, weighted_interleave_auto_show,
> > +			   weighted_interleave_auto_store);
> > +
> >  static void wi_cleanup(void) {
> > -	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> > +	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
> 
> If we use wi_auto_attr directly here, we can remove auto_kobj_attr field
> from struct sysfs_wi_group?

Hi Ying, thank you for this comment. I should have caught it as well.
Removing the last users / setters doesn't seem complicated.

Andrew, I'm very sorry -- do you think you can fold this fixlet in as well?
This is a minor change that removes the only users of this variable.

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d5ae36d2eda8..8581cc861945 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3543,7 +3543,6 @@ struct iw_node_attr {
 struct sysfs_wi_group {
        struct kobject wi_kobj;
        struct mutex kobj_lock;
-       struct kobj_attribute auto_kobj_attr;
        struct iw_node_attr *nattrs[];
 };

@@ -3833,7 +3832,6 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
        err = sysfs_create_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
        if (err)
                goto err_put_kobj;
-       wi_group->auto_kobj_attr = wi_auto_attr

        for_each_online_node(nid) {
                if (!node_state(nid, N_MEMORY))

Thank you both, I hope you have a great day!
Joshua

