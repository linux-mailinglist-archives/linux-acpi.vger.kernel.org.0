Return-Path: <linux-acpi+bounces-2782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C047829AF3
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6469DB21C4C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1824879E;
	Wed, 10 Jan 2024 13:12:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBC48790
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jan 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7beeb9acdceso104830039f.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jan 2024 05:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892324; x=1705497124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzWMbXMMTg6W6VzCAEl9gsNJmcnNqWajo2xDJ/JkYYU=;
        b=HQMxyXroIuBQCd2r+/e5dLZdf1c+6VUwZSZoGGeWs6X0GMdnats6GUpOvirJCIvjeH
         Y73t7koCCCkAa61boUUTB1UbD11j2Uxjwxoei/67hjYvB22drFzZHj0am/VJJhk8BHCI
         aHFXrnv7pcXL6HHwpo8geNKYQjen2WP3j0NAtUVy6pnFmWn8AEOW9wJO4vHnNwPK6siK
         XveJdmsDjCsav7Ra/AbG4YSfccyJg9bBQIiGYdumkW9VJYONKHEkVMqArQR97laVKJnn
         bvX0cbD1LZ5cks9HpIHSIv2mPXNJ24VMsdzZqmIvm89Fp+CsY2UcUdlS1SccjkYiYSAp
         oWug==
X-Gm-Message-State: AOJu0Yy6BHjF9X4lcFoks8acEQCrKJYHKsuLe/+G2LMRwNkelHoQ4luO
	nf2YrVOefKFo319pLHwGiDfNqvrGgnTvoAFAP2yL3gvwNLSI
X-Google-Smtp-Source: AGHT+IGmyUH+WqZAPycrcqZ22FTR4NRmRRjcLkr8dTQW/KlI0x4a7tvMHA4TAd5wLdApDIft7RjDQpkLMZHcL+P4bKPYDeESK/My
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:35f:e976:32b1 with SMTP id
 j8-20020a056e02218800b0035fe97632b1mr124471ila.0.1704892324584; Wed, 10 Jan
 2024 05:12:04 -0800 (PST)
Date: Wed, 10 Jan 2024 05:12:04 -0800
In-Reply-To: <000000000000bb7f1c05da29b601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006326a3060e972d33@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in __device_attach
From: syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, andriy.shevchenko@linux.intel.com, 
	dan.carpenter@oracle.com, dvyukov@google.com, gregkh@linuxfoundation.org, 
	hdanton@sina.com, keescook@chromium.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-usb@vger.kernel.org, rafael.j.wysocki@intel.com, rafael@kernel.org, 
	rientjes@google.com, rjw@rjwysocki.net, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 49378a05ce7f01a203550eb7c2ef772f6d24565c
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Thu Oct 26 15:45:42 2023 +0000

    mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b179cde80000
start commit:   d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15613e2bf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c90adbf00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

