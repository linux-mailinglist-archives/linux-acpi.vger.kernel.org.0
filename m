Return-Path: <linux-acpi+bounces-5694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D668C114E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A4C1C21807
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C511BC4B;
	Thu,  9 May 2024 14:36:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EE1E48B
	for <linux-acpi@vger.kernel.org>; Thu,  9 May 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265364; cv=none; b=lXlcxbdSWO1aYHvJLDzaMJ9cArGZvG+HK0A83Jr+903Kmnkn5IQAy0XYW3CZrCgoH3yHaYkxXM/BbPu8Ozj/3zePtYNdzQlc5i8PzyYbTCUlBbcg36NLqH6pK1ngVskwUoXCSCnySg4BIvevSP8xwRYhi0Xx1qApyf8fKkDTl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265364; c=relaxed/simple;
	bh=rt5PATXtgqvidD0vIbThIoVaGgjahZKF8YuAO7DGNVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nviVOVKIdqpx35RLfwHkH0FHfb/KOX5/TFPNjk0YYx894xr7qyvasItUs7X/5vOZi8D9nPtBfsWbuARMl4EII+Zu7xXWvvF2EqoN/PAs3MRlulC+SmY20KOBCpF28ySX4ktc/DauG7uwehhuj8LzojIeiuNilLGAQB+3h6w0+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da42f683f7so68108439f.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 May 2024 07:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265363; x=1715870163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X32bctqqt9YMYnQBW0Lg5lwXOgThd7oCwO6YJh7J808=;
        b=GAXNHcCcG6m8SlT42rNHfVUeSPrbQk8g16AT3frKE4BcRgvzhPPXHClOXL9LDIVtXS
         Czhftj5N/yzRYK2OrZody7QHDbR/o/SVmmO44p1YMULo8zGLrmxoWwdyo6p7aHY3xPBr
         nNzZ/l5RHSG5H5fIAAOXrNtF08kU6zjOnWuuZkjhiirVjUrX5XC/6QqhdEzW+INHRoP8
         DkyfD0eQFAaOQi9X1ydscXYopSxI5iRVVdQoxgK5OWh0s6yWSJj4Xtr1nrkXVHaDhmWa
         xv86twZOpPM+ADVTV2+OvoUj5d0xKiWJB/QAAr3INncJa0skAk1gQQu4WGISt4vUD4eb
         wTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJaEvum7dw7oVIl3S7XklAUoAxhyG9sdVD8DzjKzv/TYsG4fpH1SMmAIlFoV4lLyTxfXtiNrGpVZ0McDTmzjtzXAwDMaOiBTdI/Q==
X-Gm-Message-State: AOJu0YyzRZ+ArZQcfSzhSLxgP9+CZN6nH3A4YERBTI+hKGzO5LoCVCXv
	QbXVaWclf4cXnwgTTx1UrXysyiqrgqbDc5i6mAKoBp1fYv/MCEXGPCL1RZa7nFkUGA0tu589W7N
	Bq6zDg83VAaDZc4tqCaChab0TzJWMx/qWEHnJM6WxQajG6g3PdeA+VT8=
X-Google-Smtp-Source: AGHT+IFimP6/xLNj6bRq14TVADGedsYjqOqb/Ip4x4SwfekNgdENtprvWAAa39kLDpMwHtQipO9EAyntjoMdl6ej5XC0oqgaAmGw
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3429:b0:7de:e75e:6170 with SMTP id
 ca18e2360f4ac-7e18fd9b171mr5574039f.2.1715265362643; Thu, 09 May 2024
 07:36:02 -0700 (PDT)
Date: Thu, 09 May 2024 07:36:02 -0700
In-Reply-To: <0000000000008ac77c0615d60760@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2dd340618065661@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in sys_wait4 (4)
From: syzbot <syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, lenb@kernel.org, 
	lgirdwood@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oder_chiou@realtek.com, perex@perex.cz, rafael@kernel.org, 
	shumingf@realtek.com, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 51ea51b18904cd1a0fb244ce41dfd903c2ada628
Author: Shuming Fan <shumingf@realtek.com>
Date:   Fri Dec 23 05:58:46 2022 +0000

    ASoC: rt711-sdca: add jack detection mode for JD2 100K

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123e6f88980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=113e6f88980000
console output: https://syzkaller.appspot.com/x/log.txt?x=163e6f88980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6969434de600a6ba9f07
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091a5f6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22c13180000

Reported-by: syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com
Fixes: 51ea51b18904 ("ASoC: rt711-sdca: add jack detection mode for JD2 100K")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

