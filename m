Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A299CC32
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfHZJHi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 05:07:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55229 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfHZJHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Aug 2019 05:07:38 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 09345d57c90a9dad; Mon, 26 Aug 2019 11:07:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/9] ACPICA 20190816 release
Date:   Mon, 26 Aug 2019 11:07:35 +0200
Message-ID: <7938524.fjo6aGFHCJ@kreacher>
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, August 16, 2019 11:43:19 PM CEST Erik Schmauss wrote:
> This patchset contains the ACPICA 20190816 release. Most notable changes
> include the new _OSI string and increasing the max owner ID.
> 
> Bob Moore (6):
>   ACPICA: Increase total number of possible Owner IDs
>   ACPICA: Macros: remove pointer math on a null pointer
>   ACPICA: Fix issues with arg types within printf format strings
>   ACPICA: iASL,acpi_dump: Improve y/n query
>   ACPICA: Fully deploy ACPI_PRINTF_LIKE macro
>   ACPICA: Update version to 20190816.
> 
> Colin Ian King (1):
>   ACPICA: Debugger: remove redundant assignment on obj_desc
> 
> Jung-uk Kim (2):
>   ACPICA: Differentiate Windows 8.1 from Windows 8.
>   ACPICA: Add "Windows 2019" string to _OSI support.
> 
>  drivers/acpi/acpica/aclocal.h             |  4 +-
>  drivers/acpi/acpica/acobject.h            |  2 +-
>  drivers/acpi/acpica/acstruct.h            |  2 +-
>  drivers/acpi/acpica/acutils.h             | 10 ++-
>  drivers/acpi/acpica/dbhistry.c            |  2 +-
>  drivers/acpi/acpica/dbinput.c             | 10 +--
>  drivers/acpi/acpica/dbmethod.c            |  4 +
>  drivers/acpi/acpica/dbobject.c            |  1 -
>  drivers/acpi/acpica/dbstats.c             | 92 +++++++++++------------
>  drivers/acpi/acpica/exdump.c              |  6 +-
>  drivers/acpi/acpica/nsaccess.c            |  2 +-
>  drivers/acpi/acpica/nsalloc.c             |  2 +-
>  drivers/acpi/acpica/nsdump.c              |  2 +-
>  drivers/acpi/acpica/nsrepair2.c           |  2 +-
>  drivers/acpi/acpica/tbdata.c              |  1 +
>  drivers/acpi/acpica/utdebug.c             |  4 +-
>  drivers/acpi/acpica/uterror.c             |  6 +-
>  drivers/acpi/acpica/utosi.c               |  3 +-
>  drivers/acpi/acpica/utownerid.c           | 12 +--
>  include/acpi/acconfig.h                   |  4 +-
>  include/acpi/acpiosxf.h                   |  1 +
>  include/acpi/acpixf.h                     |  2 +-
>  include/acpi/actypes.h                    | 20 ++---
>  tools/power/acpi/tools/acpidump/apfiles.c | 10 ++-
>  24 files changed, 110 insertions(+), 94 deletions(-)

Whole series applied, thanks!




