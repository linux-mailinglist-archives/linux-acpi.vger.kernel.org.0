Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F131C102954
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfKSQ0E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 11:26:04 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38160 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfKSQ0E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 11:26:04 -0500
Received: by mail-oi1-f173.google.com with SMTP id a14so19479411oid.5;
        Tue, 19 Nov 2019 08:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRJee7nxzo39BqBz0UJpElsLIF+EqnwQjeBJ00aJBAY=;
        b=lbEH4fSd4hfsjt/33+Tj9T+D8DQGuIP/+dxaKkV+RJiI6bWxBsQhoKiDDQEQ0h8p/6
         D4kFh4xJg4LKjozEq1+Q6887BrZl7lWQ/TOrXzRZ+7DjOtU2HRVSLmOLgB/NqgSctQPo
         h/wsgBSx7fzrh9ROPf3CKMkOqi6T6rHvQOs+glPUeLwIrlmgPVQXwnjBSXJb4M+IVHJ4
         7fd/xZMb9talsB0fvvIhapQ6ADOCdEkaOEaFqLjThuhYE3mRLnqvBqiQrRmEDgrrIiBR
         W3ZNIjIazoZQ1Drnglyw3MyiORtED8LXy2wvo3GlsutA4sRL9jbjdz24JSkWeS+MS4U/
         p4hQ==
X-Gm-Message-State: APjAAAWT2GXzI45nLSjZvwQgyE3W8uCEoDTvaSqkqK9Wie+FROseuQsm
        nrnOYNcgc/221xGgwzYzuz9U255nDg2MVfF3c50=
X-Google-Smtp-Source: APXvYqwSIosCDYwJalY/pWzTCo9I/Qus4/YSATjCZtrPT+N9E3j6eE4yxz0TGLnPR7dkMNO13daALFyZPvhkgMSMiKk=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr5002167oih.57.1574180763016;
 Tue, 19 Nov 2019 08:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20191119145146.GA25855@paulmck-ThinkPad-P72>
In-Reply-To: <20191119145146.GA25855@paulmck-ThinkPad-P72>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Nov 2019 17:25:51 +0100
Message-ID: <CAJZ5v0iL=O5tjAa796SqMH7HKSaTZOGJS3xEtY8dPqDX47001Q@mail.gmail.com>
Subject: Re: next-20191118 rcutorture gets lots of "ACPI: Masking GPE 0x0"
To:     paulmck@kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 3:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello!
>
> I had occasion to run rcutorture on next-20191118, and in a five-minute
> run got 1,810,735 instances of "ACPI: Masking GPE 0x0" printed to the
> console.  This run is under qemu on an ordinary x86 laptop.
>
> Is this a known issue?

Yes, it is.

The patch causing it has been dropped, another version of if (which
should not cause the issue any more) is under testing.

Cheers,
Rafael
