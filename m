Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0071D14F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2019 23:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENVcY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 May 2019 17:32:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61996 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENVcY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 May 2019 17:32:24 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 0344fabe06f5544e; Tue, 14 May 2019 23:32:22 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix ACPI object references
Date:   Tue, 14 May 2019 23:32:21 +0200
Message-ID: <2153412.4J2ck81R4s@kreacher>
In-Reply-To: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
References: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, May 10, 2019 11:46:01 AM CEST Sakari Ailus wrote:
> Hi all,
> 
> This set adds one patch for converting spaces to tabs before fixing the
> object references. Also rebased on the patch converting the text
> documentation to ReST.
> 
> Sakari Ailus (2):
>   Documentation: ACPI: Use tabs for indentation
>   Documentation: ACPI: Direct references are allowed to devices only
> 
>  .../acpi/dsd/data-node-references.rst              |   6 +-
>  Documentation/firmware-guide/acpi/dsd/graph.rst    | 120 ++++++++++-----------
>  2 files changed, 63 insertions(+), 63 deletions(-)
> 
> 

Both patches applied, thanks!




