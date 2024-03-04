Return-Path: <linux-acpi+bounces-4083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1220E8701A8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 13:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445CC1C22607
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77EB3D0C8;
	Mon,  4 Mar 2024 12:37:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EF35894
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555824; cv=none; b=T0I11qBXSQJiiXlWE6XQr2jKzfOhY03olWGw79T+W4QU01j2gDkGwEFwdhQmuRmYkBPmcHVeOj57COXxQPIO8TaMCGCwBOMK7uU4ScLPv9k7TYLOcLMJOEqdo58k23nS7dP9m9St8fr8LKf8zoJKQR2mCVlDyt8yCBj28CJ139c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555824; c=relaxed/simple;
	bh=eylvi3XlKAQDcDq2lF5jwYNjHDysndBP8IqQugOeCVA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hopZHbBVZ0Gg65eyh6d03aTSPCq28A3qB7+dK96ERrG8dtjO+0P8kVfYBgAZXyIfbTG7lRMMbOraFt7yQ2OyibNwkmcwKOvIFGlojkubXrvBfBGzGOuRjFEFQWPLL8YHt3S+2PSb31qVU9L26WOequiYMcvkJZg15iw5bKx+0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c495649efdso580268439f.2
        for <linux-acpi@vger.kernel.org>; Mon, 04 Mar 2024 04:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555822; x=1710160622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NbNnyhd/B5XCppDwpIFPOlZsSIrkjocsr4QA1pmJsU=;
        b=cjWRmh0drGoHPt9nC4PDD4E6t3DcnU/aA/cCg+SmBo/wIlmYbIdOMq43jgshjE3j0T
         xxc32yNRZKKAR2GEgiiFuo+UdaS6bX6CB9Mw7GGyFJ/5qZ+ng2VeFEhefytaolhSFWhZ
         9UrmYbsQOqbYj1DyHWjx8EfcavhGr0Lypuzg1R5znG8tAfIGp+qVzVoYnnC1UEuJeoeP
         OFPGHu/SEqHDxyK99+PbRJuplTX7wqRpOqEIU1lSH/96GxhKVp7G4h4/sd4UuR7mSpEv
         rnRynChIk0e/s03bzWSru1JiAKAVmApMil560k5uTS6B6E+Udnhq3V7cQqP+Tt6mgTu4
         IsOg==
X-Forwarded-Encrypted: i=1; AJvYcCVfWshAgXb1OFtYm8TQa4AuvDrb9ZzchgJ/cwHL9EvwIeLr2xPTi5F/ZXo8qY69LmaX2toxYQcqXDkcDHTmyFPG64UphX8kzh9cEQ==
X-Gm-Message-State: AOJu0YzbGStPeE1B1+hJP6YynN8r0zzXguXTJ9Dx+2vRiZfplVCJ4DtJ
	ff6eCSYHAv+zxGvaNedAyesgcFqwGQ4HPuZVPngWGUhnqkQewU+1GHNTTzWVgDA7zGX0qLFNStB
	59NjlHPrT3/V/+3DZc0HMds2GQkmnwNB3Xa8wjfjRoCpwx9l6riybDls=
X-Google-Smtp-Source: AGHT+IFU4f03ZjvncZbdrXzXkVo0rpMKA/5FLqVUEdHywCy6BHCHtXYsDtg0Q9xCSX48Dp1C+/EwiWItU9BDpYG49ks9cOYOlbX2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:474:ecf8:1f55 with SMTP id
 m35-20020a05663840a300b00474ecf81f55mr190193jam.4.1709555821881; Mon, 04 Mar
 2024 04:37:01 -0800 (PST)
Date: Mon, 04 Mar 2024 04:37:01 -0800
In-Reply-To: <0000000000009dc57505fd85ceb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cb7130612d4fb95@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in rcu_core (2)
From: syzbot <syzbot+b23c4c9d3d228ba328d7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, dvyukov@google.com, jack@suse.cz, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	rafael@kernel.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yukuai1@huaweicloud.com, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e58b32180000
start commit:   e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=b23c4c9d3d228ba328d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d6dfc0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161de580a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

