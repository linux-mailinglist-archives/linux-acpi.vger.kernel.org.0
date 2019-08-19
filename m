Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD85A920BE
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfHSJwM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 05:52:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48309 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSJwM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2019 05:52:12 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 11e656f87402486f; Mon, 19 Aug 2019 11:52:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to enable dGPU direct output"
Date:   Mon, 19 Aug 2019 11:52:09 +0200
Message-ID: <2215840.qs0dBhReda@kreacher>
In-Reply-To: <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com> <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, August 15, 2019 12:47:35 AM CEST Dave Airlie wrote:
> On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> >
> > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> >
> > The original commit message didn't even make sense. AMD _does_ support it and
> > it works with Nouveau as well.
> >
> > Also what was the issue being solved here? No references to any bugs and not
> > even explaining any issue at all isn't the way we do things.
> >
> > And even if it means a muxed design, then the fix is to make it work inside the
> > driver, not adding some hacky workaround through ACPI tricks.
> >
> > And what out of tree drivers do or do not support we don't care one bit anyway.
> >
> 
> I think the reverts should be merged via Rafael's tree as the original
> patches went in via there, and we should get them in asap.
> 
> Acked-by: Dave Airlie <airlied@redhat.com>

The _OSI strings are to be dropped when all of the needed support is there in
drivers, so they should go away along with the requisite driver changes.

I'm all for dropping then when that's the case, so please feel free to add ACKs
from me to the patches in question at that point.

Cheers,
Rafael



