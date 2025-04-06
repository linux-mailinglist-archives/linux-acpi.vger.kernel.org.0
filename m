Return-Path: <linux-acpi+bounces-12766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57021A7CE1E
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099E2188DAB0
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4782628D;
	Sun,  6 Apr 2025 13:31:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83344A24
	for <linux-acpi@vger.kernel.org>; Sun,  6 Apr 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743946264; cv=none; b=A4kPo9kwuDqwzU0xDhLWV41Eo2riaPBP+mDlhHfbqCLelJ9V0ltg4MtgckrgZOQd713D0QWHyBmBJl0Suk658lDHjpWtVJNDkzjiTQlGyev0erY+tViFDhBrcKSvjDprKlxxL4jhKl8vuOTICF2jq99jXMzS5etueA0d9L5i3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743946264; c=relaxed/simple;
	bh=FyCjynRA47mn0pUjepfHMQfOYT0IfKFifac/iBUAgjM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=crhjYNEMUeW2T+aPMAf8Gj/d2StXkK18BWe5E2GKHN68ysW+26cwLy24+wDjTOs9wqfwZiUyqbC4Ncp+m2v2SZeAlAZ7CMxYrx1UQG9Q/iWXpKWiH0Q9lG+Dr/vcmgwFkIm/wIS3i2mH6sQv7xYdK8O4v/ddv4sasHiOah3VHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85be9e7bf32so804246239f.0
        for <linux-acpi@vger.kernel.org>; Sun, 06 Apr 2025 06:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743946262; x=1744551062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0Y5mkblPB7hNGkvpzm4wg+a6EjM9rmrDhLmS7LNNCY=;
        b=KyTBaoLyuMm4374cLtF1AA1BKFLAi9qoW2l6wzUO2EsVmwbxG1qrY/5VU31MzSTx66
         LmkOAwbVJ+vUe6xLtr/rcroK0SsXFEo/vm31jStLmGQxIGWVdCOpXYDONE5pPXgY20rn
         zqVopJHcaoCp7rjsdIS1cFRpvPZ8ClzL5vOBtF5FHddt9R52aJ4GojEEyot+SJ/I1ocY
         bFnCkhvmvi8oF4kXZoFHySQdp38USzdob8XYiumTqTT6OHjDXL2J3Nn5cFSyh/BTWCw/
         drt77ITdYNrf98Mhyt/iC68o3Z5MunZ6ftt98FLlhZlRHOOvQ6yg+cSCtfwFu2rMneQw
         YEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7zXhXw8D6OZmb0MEIc40eq7Q1bO+CAOVwphx1jq3/cMyD/EAdAtIO35RDAFVpywUd+rDwnaix6I2z@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIUsUaBsMQH1gDl5fTI3WgVTVUMh+gmPdtUFK4KN5zkKoCeGJ
	X137ts6u8RVQmHYgcrgZ6d09QDnvs6jFJTC8dh7YkChhrmy8LZYWy3pUV8qpKnq4SnSPBAY6NBw
	UfHfzVhaPek+5En6/Kx1PfhKUexShI0lJCvUps+MsTJkcc/GriPj2lHg=
X-Google-Smtp-Source: AGHT+IF8UVFctTmC2vxyNN8r60tVGscuZqpdo+yEbHBc8Dw98Crwk3GhpZq67SzP62Ylj2xMv94PaCiaL5vymyRWPNRVhOCsuQmV
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:3d3:f7ed:c907 with SMTP id
 e9e14a558f8ab-3d6e3f65597mr98419065ab.15.1743946262040; Sun, 06 Apr 2025
 06:31:02 -0700 (PDT)
Date: Sun, 06 Apr 2025 06:31:02 -0700
In-Reply-To: <Z_J94Up33luYw6Xg@smile.fi.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f28216.050a0220.0a13.0269.GAE@google.com>
Subject: Re: [syzbot] [acpi?] KASAN: slab-use-after-free Read in software_node_notify_remove
From: syzbot <syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com>
To: andriy.shevchenko@linux.intel.com, dakr@kernel.org, djrscally@gmail.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, jgg@nvidia.com, 
	kevin.tian@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, rafael@kernel.org, 
	sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@bitbucket.org:andy-shev/linux.git/test-swnode: failed to run ["git" "fetch" "--force" "f7e55974102a831d64e9ca077790e9122f71f6c9" "test-swnode"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@bitbucket.org:andy-shev/linux.git test-swnode
kernel config:  https://syzkaller.appspot.com/x/.config?x=24f9c4330e7c0609
dashboard link: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
compiler:       

Note: no patches were applied.

