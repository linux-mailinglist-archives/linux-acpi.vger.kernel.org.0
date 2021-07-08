Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5583C1969
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGHSyb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:54:31 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:58594 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229497AbhGHSyb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jul 2021 14:54:31 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6B23318086DED;
        Thu,  8 Jul 2021 18:51:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 66C9420D764;
        Thu,  8 Jul 2021 18:51:47 +0000 (UTC)
Message-ID: <889de6fc8688edc0f846448b94af299709fa65b8.camel@perches.com>
Subject: Re: [PATCH 01/13] mailbox: pcc: Fix doxygen comments
From:   Joe Perches <joe@perches.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 08 Jul 2021 11:51:45 -0700
In-Reply-To: <20210708180851.2311192-2-sudeep.holla@arm.com>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
         <20210708180851.2311192-2-sudeep.holla@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.06
X-Stat-Signature: y1u5xd7fducksg3d7pbfxuxii1hk4ntd
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 66C9420D764
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+nkHLgeMjL3rLMZg7NmNd8myhEe2RWpg8=
X-HE-Tag: 1625770307-297460
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-07-08 at 19:08 +0100, Sudeep Holla wrote:
> Clang complains about doxygen comments too with W=1 in the build.

just fyi: it's not a clang message, it's kernel-doc that complains.

./scripts/kernel-doc -none drivers/mailbox/pcc.c


