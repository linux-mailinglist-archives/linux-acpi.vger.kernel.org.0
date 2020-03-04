Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E04178EF4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgCDKxE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:53:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43875 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387850AbgCDKw6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 05:52:58 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id c8a51d99c2fb8d5f; Wed, 4 Mar 2020 11:52:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2 0/6] ACPI: EC: Updates related to initialization
Date:   Wed, 04 Mar 2020 11:42:07 +0100
Message-ID: <2411774.6kdisLRoUK@kreacher>
In-Reply-To: <2094703.CetWLLyMuz@kreacher>
References: <2094703.CetWLLyMuz@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On Thursday, February 27, 2020 11:19:19 PM CET Rafael J. Wysocki wrote:
> 
> The purpose of this series of update of the ACPI EC driver is to make its
> initialization more straightforward.
> 
> They fix a couple of issues, clean up some things, remove redundant code etc.
> 
> Please refer to the changelogs of individual patches for details.
> 
> For easier access, the series is available in the git branch at
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-ec-work
> 
> on top of 5.6-rc3.

The above is still true, including the location of the git branch containing
the changes.

Since the original submission, the series has been rearranged to reduce
artificial dependencies between the patches and the last patch (previously
[4/6]) has been reworked to take deferred probing into account properly.

Thanks!



