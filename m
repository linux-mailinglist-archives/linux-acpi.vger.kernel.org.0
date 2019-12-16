Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32364120385
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 12:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLPLQN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 06:16:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46034 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLPLQN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 06:16:13 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 038a9e5e7a342150; Mon, 16 Dec 2019 12:16:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     kc27041980@gmail.com
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] acpi/ec.c: Move call to kref_get() to under the mutex_lock(&ec->mutex)
Date:   Mon, 16 Dec 2019 12:16:10 +0100
Message-ID: <71678431.1RUZMxPmvT@kreacher>
In-Reply-To: <1574679798-18958-1-git-send-email-KC17041980@gmail.com>
References: <1574679798-18958-1-git-send-email-KC17041980@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, November 25, 2019 12:03:18 PM CET kc27041980@gmail.com wrote:
> From: KC27041980 <kc27041980@gmail.com>
> 
> Move call to kref_get() to under the mutex_lock(&ec->mutex) as this
> will remove any delete race scenarios.
> 
> Signed-off-by: KC27041980 <kc27041980@gmail.com>
> ---
>  drivers/acpi/ec.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index da1e5c5..9c1bd57 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1073,8 +1073,12 @@ acpi_ec_get_query_handler_by_value(struct acpi_ec *ec, u8 value)
>  			break;
>  		}
>  	}
> +
> +	if (found)
> +		acpi_ec_get_query_handler(handler);
>  	mutex_unlock(&ec->mutex);
> -	return found ? acpi_ec_get_query_handler(handler) : NULL;
> +
> +	return found ? handler : NULL;
>  }
>  
>  static void acpi_ec_query_handler_release(struct kref *kref)
> 

Well, what about the appended patch instead?

---
 drivers/acpi/ec.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1053,28 +1053,20 @@ void acpi_ec_unblock_transactions(void)
                                 Event Management
    -------------------------------------------------------------------------- */
 static struct acpi_ec_query_handler *
-acpi_ec_get_query_handler(struct acpi_ec_query_handler *handler)
-{
-	if (handler)
-		kref_get(&handler->kref);
-	return handler;
-}
-
-static struct acpi_ec_query_handler *
 acpi_ec_get_query_handler_by_value(struct acpi_ec *ec, u8 value)
 {
 	struct acpi_ec_query_handler *handler;
-	bool found = false;
 
 	mutex_lock(&ec->mutex);
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
-			found = true;
-			break;
+			kref_get(&handler->kref);
+			mutex_unlock(&ec->mutex);
+			return handler;
 		}
 	}
 	mutex_unlock(&ec->mutex);
-	return found ? acpi_ec_get_query_handler(handler) : NULL;
+	return NULL;
 }
 
 static void acpi_ec_query_handler_release(struct kref *kref)




