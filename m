Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE83BA824
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Jul 2021 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGCJsr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Jul 2021 05:48:47 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:41710 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229993AbhGCJso (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Jul 2021 05:48:44 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jul 2021 05:48:44 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 02C471814F402
        for <linux-acpi@vger.kernel.org>; Sat,  3 Jul 2021 09:38:05 +0000 (UTC)
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id EC976101A3244;
        Sat,  3 Jul 2021 09:38:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 60B691A29FE;
        Sat,  3 Jul 2021 09:38:02 +0000 (UTC)
Message-ID: <00de2918fb9bfc46d330a72c535892d8ab992483.camel@perches.com>
Subject: Re: [PATCH] ACPICA: fix if condition
From:   Joe Perches <joe@perches.com>
To:     gushengxian <gushengxian507419@gmail.com>, robert.moore@intel.com,
        erik.kaneda@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Date:   Sat, 03 Jul 2021 02:38:01 -0700
In-Reply-To: <20210703091218.650202-1-gushengxian507419@gmail.com>
References: <20210703091218.650202-1-gushengxian507419@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 60B691A29FE
X-Stat-Signature: i6ecosg6rgzwagjcnhqdoy6xdkhtdqnp
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/eBocd42y4w2i2SvyF/lBhyz4B2Rynd40=
X-HE-Tag: 1625305082-867487
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 2021-07-03 at 02:12 -0700, gushengxian wrote:
> From: gushengxian <gushengxian@yulong.com>
> 
> Fix if condition.

A few more of these...

drivers/platform/x86/thinkpad_acpi.c:		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, ret, battery))
drivers/platform/x86/thinkpad_acpi.c:		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_STOP, ret, battery))
drivers/platform/x86/thinkpad_acpi.c:		if ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_START, &ret, param)) {
drivers/platform/x86/thinkpad_acpi.c:		if ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_STOP, &ret, param)) {
drivers/platform/x86/thinkpad_acpi.c:		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
drivers/platform/x86/thinkpad_acpi.c:		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_STOP, &ret, battery)) {


