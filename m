Return-Path: <linux-acpi+bounces-9545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D9C9C6F06
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 13:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C469C1F21E81
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2561FF7D9;
	Wed, 13 Nov 2024 12:27:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA01F8906
	for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500825; cv=none; b=o9QZQCL4xkLbSxBc9RT86XnGrgV08AQKVZh3FGoA95JZspXzC2x/TLTYA6Hni91aNpjFfU1o+k/Sw7INwQNyGQNzp05cSWJVUlVTSQmELmz79ylnNCaOw72+HNZWxu/PPO6HHthU7CiAq+WW+aUln02+L/1A7OoCTBdIiJX6e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500825; c=relaxed/simple;
	bh=xiNg5znueipvPFwimPHq7hUeF96APnXAhZtTEakQbl8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zf01N2ate7te4E9NDZumgtrYBkS5pvwp7Mh4GUKsIyiImc2CW4pxiS2uhYloybz1a+NqOTMfmRpuEWR9pOVRkPf9c6REyIP7FQS8VlAWvExJmQ/QBQ2SGTB0H8YtD0y/RY2NTUgY7LLu/p5TpNY647wJA+e/eSzckyNrwBUFvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6c1907eeaso85010585ab.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 04:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731500823; x=1732105623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkcdwbKwC54ksa1xeYHfLKc13WBWF+TVFlXOuA4rNF0=;
        b=ANi4sgLoCOOCCfHrLlQINMqxsdOHOWdaqvpkzCWxH7DZ35u30kEYhv6FU90QffmK8k
         8XFbNjGeHuDRFeTQBh/hXT2aOHEvKnjEPC0hWbRVUbcsEb6wJddf0fYVSvO31EI04avR
         cf1uw5DwIC1c1/ofcVotgC6WDaer2pbeg997XOToE1muNbaNqxb3IgIVPypCcpWC5f/D
         MSErQXgoN7tLXnxzmtpFnCVNUOi3/TylURekBkgwfWQeCHKlVwsngp6jK1LA9TLUdM/a
         DTl8kLxzkc+CxzbJ1PwgCVdTe6omY56kaokWLU8/jHhBgzUM+rGGtMqaGVq4ULanrmYa
         ljjA==
X-Forwarded-Encrypted: i=1; AJvYcCWca/9xrVaqmQebS1DXR8yXtlRypk1MDTvwDUwYqhLbBG0dAAwZtOq6dkm6L8mTvCQOqW1373/0byzf@vger.kernel.org
X-Gm-Message-State: AOJu0YybhQRSWLtFf1bvF133QBPT4kMkXSVCHzUrYBCYF4yJgYZrIeis
	otwh75uTXE8Gu6Q2DZgJ31SD7pMw+7Cz4mMSYuvOTQuUbUJZ72Gu1RkH+N6pQIAmLrDGM38pyZv
	HG4/QmjjUwNvirVC5Rl7X3ZUpU9qDCR+4RdZFV1FN7rkR9mvlQtUSQAw=
X-Google-Smtp-Source: AGHT+IH3YeeJ2wjRzyTxUBU/Fz7blpElgbrjvFEVwsIv4HlOM4uInB40FGzuJCij+kZxQsisXAtEUePo4IU5xrL3FSdx7sDQuG9E
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:3a3:b5ba:bfba with SMTP id
 e9e14a558f8ab-3a6f1a6440dmr210634735ab.15.1731500822810; Wed, 13 Nov 2024
 04:27:02 -0800 (PST)
Date: Wed, 13 Nov 2024 04:27:02 -0800
In-Reply-To: <CAHiZj8j+=3paytYbPMDqof6cVYxSFjjaev1PTc0EUsNz8hXExg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67349b16.050a0220.2a2fcc.000c.GAE@google.com>
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

commit:         f1b785f4 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ca8df7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d20b5f980000

Note: testing is done by a robot and is best-effort only.

