Return-Path: <linux-acpi+bounces-9486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E569C31B3
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Nov 2024 11:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD02816FE
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Nov 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F69154457;
	Sun, 10 Nov 2024 10:55:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94714F121
	for <linux-acpi@vger.kernel.org>; Sun, 10 Nov 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731236104; cv=none; b=hbl+iQlBqWcQ69xaxYZeNoJcEzU7M7Dg4Sfp291qQIjygD88a4hp2xopufOHSUjYzPpK1k/42LeatK3ux19qx2B7JvbCJcvxlmRUqEHy6VbA7Syc/Tu+wvVbxH8wfooap7W5jI1DN/JbazxxEtUsy6wRy8q3vR/q3wG/gddlgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731236104; c=relaxed/simple;
	bh=qp30AENi8dcgpbgR8q8aWwhedRUsRchicjsEyep+G7E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JquD5mglTkNbuez2hnlpOeeSR4aUkThJOIukpnYEJWTnGqC0hy5522x0gpoBXvSD1DDqwflq+g1rEvhZTfYbSc2v8FHzeyeGCk+kLSBVq0VNqLT1qsTlSWrrqVgdRlkb8g6CDIo1YWCHwGJdX227IQNDNWduLdok4wdX7dYM/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf68e7ffso425653039f.1
        for <linux-acpi@vger.kernel.org>; Sun, 10 Nov 2024 02:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731236102; x=1731840902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkrHgi6tIDZKDVhNeZ89zrLoylCI9aMkz19AD8osQ10=;
        b=slL+FsB1BGAj543pwBBfbvcMslrLvSTTWk6t+kQ92qaElw438wAPTD7IJwCKwwDqcs
         oxNv4HS68Qoo7W4jp09zeoB4jjaQzvp4nXQlDNW8Gy/X+70vUexzbjAwSp8TIqzN8erO
         W6Lr0Ca5eo0F5cOr/6EyU/sTSyut2hO0Y3o7DkxTnAWOxiGGBsEZlhnYN1xVlKxMxRQ9
         GIEKgI8wAsi07w79jn0uz2WajulgVOdazAlVtaaXjeQMEIE3VwRqElWNulRjBv2vQCsA
         uSnBIeZha9SUwIchmZHIJU9RUP0JUiI+bU32WHpsnypEwwK83wwZgSOc2YuqYc4JFX5g
         RU6w==
X-Forwarded-Encrypted: i=1; AJvYcCU7XIi1p6SD/U9VfzpwVV2rkPP5R3gWJIh8M1mzyU27ohsnbfwiWhY5Pd/KJWbE5zSAuStIl+VVkBsv@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrYtU5+OXryKwtgUq7pqiLEE6Kg2kLrKULvIKKw9W6jR5qznH
	GXZw5S15+++IkUGT1fa7T5zuNel4zrX9FIKovP81rGdTU0okkNm5s/jG4uq/+3tCG467zUNDhv8
	p3knafVTZIx2CbGtH8jPIryyq2A+m/plaby9fwDKkxmo/in4FnSJySWM=
X-Google-Smtp-Source: AGHT+IFAs92Gwb0aXQftJab7U5XVyZHIVCEeOqd1umax+/Rh6VlSO2sxjsRp1vnO1AhdxCcikj3wrFudLW+Sqm7j3Nry1ZTmiWeN
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3a6:b258:fcd with SMTP id
 e9e14a558f8ab-3a6f19a01c1mr98799655ab.1.1731236102561; Sun, 10 Nov 2024
 02:55:02 -0800 (PST)
Date: Sun, 10 Nov 2024 02:55:02 -0800
In-Reply-To: <CAHiZj8ieKPXqLKx4oO6Vhb0QPU+8hF9B-gaQ=Xinawrqv86==w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67309106.050a0220.320e73.0322.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com, vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         de2f378f Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102594e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11629ea7980000

Note: testing is done by a robot and is best-effort only.

