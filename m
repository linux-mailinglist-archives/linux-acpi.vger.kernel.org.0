Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB766AFA75
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2019 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfIKKeK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Sep 2019 06:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfIKKeK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Sep 2019 06:34:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 458512087E;
        Wed, 11 Sep 2019 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568198049;
        bh=d8af/NoTc5C2mwDiZ3UX/0hSVyDtHPhIx/OUpWcj78s=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=jS57VgcOSOgDaqmIBHE5tj4OcI2/p7VRBAlxMnNYlokNjAg3mQkSrFU2bWmOczTx8
         JNkP1ounBNqVukMU3Z1CUaLmCMTPvhQFzI6FSDutOjxW3O6v3a2rlvqLpzWIyzR0zl
         xj2FLWM4ySWrrXC9rE537Wvz19p/okHtcCAsMwWY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190904211126.47518-1-saravanak@google.com>
References: <20190904211126.47518-1-saravanak@google.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v11 0/6] Solve postboot supplier cleanup and optimize probe ordering
User-Agent: alot/0.8.1
Date:   Wed, 11 Sep 2019 03:34:08 -0700
Message-Id: <20190911103409.458512087E@mail.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Saravana Kannan (2019-09-04 14:11:19)
> v10->v11:
> - Dropped 6/7 and 7/7 from previous series that tried to handle cycles in=
 DT
>   dependencies. We can solve it later when we actually hit a real world i=
ssue
>   in DT.
> - Added a new 1/7 that shifts the numbering for the rest of the patches
> - 1/7 adds a way to look up a device from a fwnode so that this series ca=
n work
>   across bus and firmware types
> - 3/7 removed references to platform_device from of/property.c
> - 4/7 Minor variable rename
> - 4/7 Defer sync_state() be default at driver core level and resume at
>   late_initcall_sync(). That way, we don't depend on any specific bus typ=
es
>   having to pause/resume sync_state() till late_initcall_sync()

Please reverse this list so that most recent series changes come first
and we don't have to scroll through all the history to get to what has
changed recently.

Also, please Cc me on future changes and I would suggest involving any
subsystem maintainers that this code is optimizing for. Looks like Mark
Brown and Georgi Djakov should be included in this series for awareness
(but it's at v11 already!)

