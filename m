Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF901CBFBA
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgEIJQG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 May 2020 05:16:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62624 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEIJQG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2020 05:16:06 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 9e5e10cf7719158b; Sat, 9 May 2020 11:16:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/6] ACPICA release 20200430
Date:   Sat, 09 May 2020 11:16:04 +0200
Message-ID: <5870801.q6vts1Q0Ho@kreacher>
In-Reply-To: <20200505004654.2870591-1-erik.kaneda@intel.com>
References: <20200505004654.2870591-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, May 5, 2020 2:46:48 AM CEST Erik Kaneda wrote:
> This series contains the linux-ized patches of the 20200430 ACPICA
> release. There are two patches to fix sparse warnings that are
> generated from global variables, and a fix to avoid null pointer
> dereferences in the dispatcher. Aside from that, there is a fix to
> correct the required parameters for the predefined ACPI methods _NIH
> and _NIG.
> 
> Bob Moore (1):
>   ACPICA: Update version to 20200430
> 
> Erik Kaneda (4):
>   ACPICA: Move acpi_gbl_next_cmd_num definition to acglobal.h
>   ACPICA: Disassembler: ignore AE_ALREADY_EXISTS status when parsing
>     create operators
>   ACPICA: Dispatcher: add status checks to avoid NULL pointer
>     dereference on field objects
>   ACPICA: Fix required parameters for _NIG and _NIH
> 
> Yue Haibing (1):
>   ACPICA: Make acpi_protocol_lengths static
> 
>  drivers/acpi/acpica/acglobal.h |  1 +
>  drivers/acpi/acpica/acpredef.h |  4 ++--
>  drivers/acpi/acpica/dbhistry.c |  1 -
>  drivers/acpi/acpica/dsfield.c  | 22 ++++++++++++++++------
>  drivers/acpi/acpica/exfield.c  |  2 +-
>  include/acpi/acpixf.h          |  2 +-
>  6 files changed, 21 insertions(+), 11 deletions(-)
> 
> 

All patches applied as 5.8 material, thanks!




