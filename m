Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1130E2E0
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 19:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhBCSwS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 13:52:18 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54328 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhBCSwF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 13:52:05 -0500
Received: from 89-64-80-249.dynamic.chello.pl (89.64.80.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id bb8086517dabd5dc; Wed, 3 Feb 2021 19:51:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v3 0/5] ACPI: More cleanups related to printing messages
Date:   Wed, 03 Feb 2021 19:40:28 +0100
Message-ID: <1961054.9MKZ8ejxOh@kreacher>
In-Reply-To: <1991501.dpTHplkurC@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On Tuesday, February 2, 2021 7:11:47 PM CET Rafael J. Wysocki wrote:
> 
> On Monday, February 1, 2021 7:14:38 PM CET Rafael J. Wysocki wrote:
> > 
> > This series is a continuation of the effort to drop ACPICA-specific debug
> > code from non-ACPICA pieces of the ACPI subsystem and to make the message
> > printing in there more consistent.
> > 
> > The patches in this series are based on linux-next from today.
> > 
> > Details in the patch changelogs.
> 
> Sending a v2 with updated changelogs to address review comments from Joe.
> 
> The code changes are the same as before in all of the patches.

Sending a v3 to address review comments from Hanjun.

Thanks!



