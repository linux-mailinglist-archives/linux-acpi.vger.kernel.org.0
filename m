Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD791B7ECC
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Apr 2020 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDXTX0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Apr 2020 15:23:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35450 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXTXZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2020 15:23:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id e26so14409221otr.2;
        Fri, 24 Apr 2020 12:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TKnErRwZ3k1+AjzoqZbolssLyNPVUP1KdGAXylkhrtI=;
        b=LflXzOO9NkcCb+4NvdC7nXHw4ZXbTqjkfaUnOdKDc1QDDlC3rR3nTRv2NHZ2RCTXo4
         e0gL1ZpKCd+/N7izkhR6XM2NuFBHDkNf1w4KQKsA7vqFRf1QF/eqc49i7DlJyrZeMTpH
         r/JyThWj7wOnNmHUyymttgTUL0cU4QTVGvtXGKOQVrxo5RjBuyugC5YHUJPxa/UfdoWK
         5az98jXagQH3YR9o25x8aWkDeQXoOLEOK3es+MwTDWqkEceX38J1UjDBudRZRDaLnKYW
         e8kEHcbMt9NepdQK4PBgF7Vai71fjcvTzQmGwOaavEBarLkkRlEpZFh0hxz/qn7JmwZn
         cmdA==
X-Gm-Message-State: AGi0PuaJMu0TfES5mvsMKKypyJVRAzjq4maq4G3x2dbpU17cEvobjL+b
        VHWlGKRNCkNkO19JMp9aSwvNNvZxbhrTkypJ4jKBAZbc
X-Google-Smtp-Source: APiQypLWDrt/xHxPq8iDeU7/yn1DFow1jsWi4MEHyD3gZ/QCSM4rcDF5yy9/m52kic/gu5Zuv3cvNTAj94NPd1GA3Ck=
X-Received: by 2002:aca:aa8c:: with SMTP id t134mr8689675oie.103.1587756205103;
 Fri, 24 Apr 2020 12:23:25 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Apr 2020 21:23:14 +0200
Message-ID: <CAJZ5v0hHNpEjdzE4QVhpb7bi43VGHdJwY17n1_pTmcXwXNtPew@mail.gmail.com>
Subject: [GIT PULL] PNP subsystem update for v5.7-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-5.7-rc3

with top-most commit 01b2bafe57b19d9119413f138765ef57990921ce

 pnp: Use list_for_each_entry() instead of open coding

on top of commit ae83d0b416db002fe95601e7f97f64b59514d936

 Linux 5.7-rc2

to receive a PNP subsystem update for 5.7-rc3.

This makes the PNP code use list_for_each_entry() in a few places
instead of open-coding it (Jason Gunthorpe).

Thanks!


---------------

Jason Gunthorpe (1):
      pnp: Use list_for_each_entry() instead of open coding

---------------

 include/linux/pnp.h | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)
