Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0493C6033F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfGEJk5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:40:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56609 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGEJk5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 05:40:57 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 4fb91fb9b4e04017; Fri, 5 Jul 2019 11:40:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/5] ACPICA version 20190703
Date:   Fri, 05 Jul 2019 11:40:54 +0200
Message-ID: <3857082.aiUXHtRYrp@kreacher>
In-Reply-To: <20190703201540.26054-1-erik.schmauss@intel.com>
References: <20190703201540.26054-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, July 3, 2019 10:15:35 PM CEST Erik Schmauss wrote:
> This series contains ACPICA version 20190703 changes that are relevant
> to Linux kernel. This patch set is available for viewing at:
> https://github.com/SchmErik/linux/tree/acpica201907
> 
> Overall, this release contains several patches that simplify ACPICA
> initialization by removing unnecessary ACPI namespace walks.
> 
> Bob Moore (3):
>   ACPICA: Namespace: simplify creation of the initial/default namespace
>   ACPICA: Update for object initialization sequence
>   ACPICA: Update table load object initialization
>   ACPICA: Update version to 20190703
> 
> Erik Schmauss (2):
>   ACPICA: remove legacy module-level code due to deprecation
> 
>  drivers/acpi/acpica/acglobal.h |   1 -
>  drivers/acpi/acpica/acnamesp.h |   2 -
>  drivers/acpi/acpica/dsinit.c   |   2 +-
>  drivers/acpi/acpica/exconfig.c |  16 ++-
>  drivers/acpi/acpica/nsaccess.c |  54 ++++++++--
>  drivers/acpi/acpica/nseval.c   | 190 ---------------------------------
>  drivers/acpi/acpica/nsinit.c   |  49 ++++-----
>  drivers/acpi/acpica/nsload.c   |  12 ---
>  drivers/acpi/acpica/nsutils.c  |  12 ---
>  drivers/acpi/acpica/tbdata.c   |  13 ---
>  drivers/acpi/acpica/tbxfload.c |  10 +-
>  drivers/acpi/acpica/utinit.c   |   1 -
>  drivers/acpi/acpica/utxfinit.c |  18 ++--
>  include/acpi/acpixf.h          |   2 +-
>  14 files changed, 79 insertions(+), 303 deletions(-)
> 
> 

All applied, thanks!



