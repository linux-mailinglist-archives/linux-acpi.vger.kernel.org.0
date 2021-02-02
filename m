Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E874A30C9AE
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbhBBSZP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:25:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48932 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbhBBSVW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:21:22 -0500
Received: from 89-64-80-193.dynamic.chello.pl (89.64.80.193) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 4c7cb095cc4c5f2c; Tue, 2 Feb 2021 19:19:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 0/5] ACPI: More cleanups related to printing messages
Date:   Tue, 02 Feb 2021 19:11:47 +0100
Message-ID: <1991501.dpTHplkurC@kreacher>
In-Reply-To: <2367702.B5bJTmGzJm@kreacher>
References: <2367702.B5bJTmGzJm@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On Monday, February 1, 2021 7:14:38 PM CET Rafael J. Wysocki wrote:
> 
> This series is a continuation of the effort to drop ACPICA-specific debug
> code from non-ACPICA pieces of the ACPI subsystem and to make the message
> printing in there more consistent.
> 
> The patches in this series are based on linux-next from today.
> 
> Details in the patch changelogs.

Sending a v2 with updated changelogs to address review comments from Joe.

The code changes are the same as before in all of the patches.

Thanks!



