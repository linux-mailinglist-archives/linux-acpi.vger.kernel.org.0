Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5464458D5A
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 23:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0Vsk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 17:48:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41030 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0Vsk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 17:48:40 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 253dea51c704b36a; Thu, 27 Jun 2019 23:48:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andrea Oliveri <oliveriandrea@gmail.com>
Cc:     linux-acpi@vger.kernel.org, lenb@kernel.org
Subject: Re: [PATCH] ACPI: BGRT table overriding
Date:   Thu, 27 Jun 2019 23:48:38 +0200
Message-ID: <5244886.yFHjjlQzhF@kreacher>
In-Reply-To: <CAN2kSaqhq1QfCQ1kM-tLr8Q0ptFQcdujgnQW-xYZKAzi_-pHAw@mail.gmail.com>
References: <CAN2kSaqhq1QfCQ1kM-tLr8Q0ptFQcdujgnQW-xYZKAzi_-pHAw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, June 10, 2019 2:45:41 PM CEST Andrea Oliveri wrote:
> 
> --0000000000007d8d9c058af78ff3
> Content-Type: text/plain; charset="UTF-8"
> 
> Thinkpad T Series expose a malformed BGRT table with Version field set
> to 0. This fact prevents bootsplashes (as Plymouth) to correctly show
> the manufacturer logo. This patch permits to override malformed BGRT
> table with a correct one defined by the user.

Applied, thanks!



