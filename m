Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3646F519A0
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfFXRed (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 13:34:33 -0400
Received: from foss.arm.com ([217.140.110.172]:55568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbfFXRed (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 13:34:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DF94CFC;
        Mon, 24 Jun 2019 10:34:32 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D07EA3F718;
        Mon, 24 Jun 2019 10:34:31 -0700 (PDT)
Subject: Re: [PATCH v2] ACPI / APEI: Remove needless __ghes_check_estatus()
 calls
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <1561376883-95788-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <35b1658d-ec98-d66e-f147-dac2629a3283@arm.com>
Date:   Mon, 24 Jun 2019 18:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561376883-95788-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Liguang,

On 24/06/2019 12:48, luanshi wrote:
> Function __ghes_check_estatus() is called after __ghes_peek_estatus(),

(Nit: 'is always called' would be clearer)

> but it is already called in __ghes_peek_estatus(). So we should remove
> some needless __ghes_check_estatus() calls.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James
